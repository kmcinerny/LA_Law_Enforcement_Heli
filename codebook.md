# Codebook
Source: https://www.radarbox.com/api/documentation#operation/search



"field": example // explanation


"comment": "Successfully fetched details for 2569 flights", // info about operation

    "cost": 2569, // cost of the operation, except this number is clearly inaccurate, as it equals the # of flights
    
    "flights": // array of flights [
        {
        
            "aircraftModeS": Aircraft Mode-S Hex code, unique ICAO 24-bit address (part of the aircraft's Certificate of Registration) used to identify the aircraft and broadcast by its Mode-S transponder.
            "aircraftRegistration": Tail number
            "aircraftType": "AS50", // ICAO code
            "altitude": 550, // altitude(feet)
            "arrAirportCity": "Hawthorne",
            "arrAirportCountry": "United States",
            "arrAirportIata": "HHR", // arriving airport IATA code, three-letter geocode designating many airports.
            "arrAirportIcao": "KHHR", // arriving airport ICAO code, a four-letter code designating aerodromes around the world.
            "arrAirportLatitude": 33.9228,
            "arrAirportLongitude": -118.335,
            "arrAirportName": "Jack Northrop Field Hawthorne Municipal Airport",
            "arrAirportState": "California",
            "arrAirportTz": "PDT", // arriving airport time zone
            "arrAirportTzDiffUTC": "-7.0", // arriving airport time zone hour difference to UTC
            "calculatedLanding": "2020-10-01T03:49:33.000+0000", //	string <date-time> (Calculated time of landing (UTC))
            "calculatedTakeoff": "2020-09-30T22:24:52.000+0000", //	string <date-time> (Calculated time of takeoff (UTC))
            "callsign": "N221LA", // flight call sign
            "created": "2020-09-30T22:17:17.000+0000", // string <date-time> (Date this flight record was created)
            "depAirportCity": "Burbank",
            "depAirportCountry": "United States",
            "depAirportIata": "BUR", // departing airport IATA code
            "depAirportIcao": "KBUR", // departing airport ICAO code
            "depAirportLatitude": 34.2007,
            "depAirportLongitude": -118.359,
            "depAirportName": "Bob Hope Airport",
            "depAirportState": "California",
            "depAirportTz": "PDT", // departing airport time zone
            "depAirportTzDiffUTC": "-7.0",  // departing airport time zone hour difference to UTC
            "groundSpeed": 50, // integer <int64> (Ground speed (knots))
            "latitude": 33.990601, // maybe of starting position? unclear
            "longitude": -118.32735, // maybe of starting position? unclear
            "positions": [ // array of positions within single flight
                {
                    "altitude": 1100, // altitude (feet)
                    "groundSpeed": 40, // ground speed (knots)
                    "heading": 130, // heading (degrees)
                    "latitude": 34.1882427668167, 
                    "longitude": -118.425178527832,
                    "source": "ADSB", // Source of the position data (ADSB, MLAT, ASDI, OCEA, SATE, HFDL, ASDEX)
                    "squawkCode": null, // Squawk code, 4-digit octal number that is assigned by air traffic control. The pilots will enter the assigned squawk code into the aircraft's transponder.
                    "timestamp": "2020-09-30T22:17:20.366+0000", // string <date-time> (Time the position was recorded)
                    "verticalRate": null // Verical rate (ft/min)
                },
