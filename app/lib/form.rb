# A form can be used to encapsulate a html form or even a service.
# The main goal is to reduce the complexity of models and keep the number of validations on models low.
#
# A form goes through
#   1. initialization (mass assigns attributes)
#   2. submission (triggered via submit)
#   3. sanitization (calls sanitize)
#   4. validations (runs all added validations)
#   5. processing (calls process)
#
# A form shall be used from a controller like this:
#     @form = SampleForm.new(params[:form])
#      if @form.submit
#        redirect_to success_path, notice: "Yey!"
#      else
#        render :new
#      end
#
# It is pretty common to copy attributes from a model and back.
# This can be done via with the helpers `copy_from` & `copy_to` (in `initialize` & `process`).
# Alternatively attributes can be annotated with `auto_copy`. Example:
#     class SampleForm < Form
#       attr_reader :sample
#
#       attribute :title , auto_copy: :sample # specify the attribute which holds the model instance
#
#       def initialize(a_sample = nil, attributes = {})
#         @sample = a_sample
#         super(attributes) # the value is first assigned the model's value, then it may get overridden by the passed attributes
#       end
#
#       def process
#         # the model's attributes are assigned with form's attributes automatically
#         sample.save! # MIND: the model(s) is not automatically saved by the auto_copy functionality
#       end
#     end
#
# Sometimes you want to access attributes before auto-copy was executed.
# If the destination of the auto-copy is an ActiveRecord model, we can get the original value by using
# the `[attribute]_was` method. E.g. `MyMailer.notify(sample.title_was)`
#
# If we want to use the auto-copy functionality only if the values are present, we can do the following trick.
#     def initialize(attributes, importer)
#       present_attributes = attributes.reject { |k, v| v.blank? } # this will not override existing values with blank values
#       super(present_attributes, importer)
#     end

class Form
  include ActiveAttr::Model

  Invalid = Class.new(StandardError)

  def self.model_name
    ActiveModel::Name.new(self, nil, "Form")
  end

  def initialize(*)
    auto_copy_from_model
    super
  end

  # do not override this method directly. Use `process` to implement your logic.
  def submit(context = nil)
    sanitize
    auto_copy_to_model
    return unless context ? valid?(context) : valid?
    process
    true
  end

  # do not override this method directly. Use `process` to implement your logic.
  def submit!(context = nil)
    was_successful = submit(context)
    return true if was_successful

    message = errors.is_a?(ActiveModel::Errors) ? errors.to_hash.to_s : errors.to_s
    raise Invalid, message
  end

  protected

  # override me in the sub-class
  def process; end

  # override me in the sub-class
  def sanitize; end

  # helper method which takes a list of field names that will be copied over from this form to the given target
  def copy_to(target, *field_names)
    field_names.each do |attr|
      target.send("#{attr}=", self.send(attr))
    end
  end

  # helper method which takes a list of field names that will be copied over from the given source to this form
  def copy_from(source, *field_names)
    field_names.each do |attr|
      self.send("#{attr}=", source.send(attr))
    end
  end

  def strip_all!(*field_names)
    field_names.each do |attr_name|
      self.send(attr_name).send(:try, :strip!)
    end
  end

  def strip_all_strings!
    string_attrs = self.class.attributes
                       .select { |attr_name, _definition| self.send(attr_name).is_a?(String) }
                       .keys
    strip_all!(*string_attrs)
  end

  # substiutes string markers such as 'nodata' or '-' with nil
  def nilify_empty_markers!(*field_names)
    field_names.each do |attr_name|
      value = self.send(attr_name)
      next unless value.is_a?(String)
      nilified = ['nodata', '-', '1900-01-02', '1900-01-01', 'null', 'missing'].include?(value.strip) ? nil : value
      self.send("#{attr_name}=", nilified)
    end
  end

  def transaction(&block)
    ActiveRecord::Base.transaction(&block)
  end

  private

  # returns a hash with the auto_copy attribute names as keys.
  # the corresponding value is the _reference_ to the attribute which auto_copy points to.
  def auto_copy_mapping
    self.class.attributes.each_with_object({}) do |(attr_name, definition), memo|
      source_attr = definition[:auto_copy]
      next unless source_attr
      memo[attr_name] = self.send(source_attr.to_sym)
    end
  end

  def auto_copy_from_model
    auto_copy_mapping.each { |attr_name, source| copy_from(source, attr_name) }
  end

  def auto_copy_to_model
    auto_copy_mapping.each { |attr_name, source| copy_to(source, attr_name) }
  end
end
