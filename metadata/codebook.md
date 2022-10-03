## Data Source
https://www.radarbox.com/api/documentation#operation/search
Scroll down to "Responses" / click on "flights" to open array of flights / scroll down and click on "positions" to open array of positions

## Structure
Each month of data contains a set of flights with several variables about the flight as a whole, 
as well as nested position data, with its own set of variables for the flight's positions taken every few seconds.
The majority of our analysis is based on the nested position data. We joined a couple of the variables, including flight_id (which we created) and aircraftRegistration (which came from the overarching flight data), to the positions data.

## Variables in Position Data
<!-- POSITIONS-VAR-LIST:START -->
| Variable | Label | Type |
| :---- | :---- | :---- |
| flight_id | unique ID we assigned for year-month-number of flight in sequential order | string |
| aircraftRegistration | identifier for the aircraft, often same as tail number | string |
| altitude | altitude (ft) | decimal |
| groundSpeed | ground speed (knots) | decimal |
| heading | heading (degrees) | decimal |
| latitude | lat | decimal |
| longitude | lon | decimal |
| source | source of the position data | string |
| timestamp | time the position was recorded (UTC converted to pacific time) | date-time |
| verticalRate | vertical rate (ft/min) | integer |
