import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'
// https://github.com/palerdot/react-d3-speedometer
import ReactSpeedometer from "react-d3-speedometer"



const getStartColor = (props) => {
  if(props.inverted){
    return '#00FF00'
  } else {
    return '#FF0000'
  }
}

const getEndColor = (props) => {
  if(props.inverted){
    return '#FF0000'
  } else {
    return '#00FF00'
  }
}


const Dial = props => (
  <div>
    <ReactSpeedometer
      value = { props.current }
      minValue= { props.min }
      maxValue = { props.max }
      startColor={ getStartColor(props) }
      endColor={ getEndColor(props) }
      segments = { props.segments }
      needleColor = '#000000'
      segmentColors = { props.dial_segment_colors }
      width = { props.width }
      height = { props.height }
      customSegmentStops = { props.customSegmentStops }
    />
    {props.dial_name}</div>
)

Dial.defaultProps = {
  dial_name: '',
  min: 0,
  max: 100,
  current: 10.0,
  inverted: false,
  dial_segment_colors: [],
  width: 300,
  height: 200,
  segments: 5,
  customSegmentStops: [],
}

Dial.propTypes = {
  dial_name: PropTypes.string,
  min: PropTypes.number,
  max: PropTypes.number,
  current: PropTypes.number,
  inverted: PropTypes.bool,
  dial_segment_colors: PropTypes.array,
  width: PropTypes.number,
  height: PropTypes.number,
  segments: PropTypes.number,
  customSegmentStops: PropTypes.array,
}

export default Dial


