
## Overarching 
* heli-data: flight trajectory data for Oct 2019-Oct 2020
    * raw: these are the raw json flight trajectories that came from the original source
    * flights: this contains a csv file with all of the flights and their nested positions
    * positions: this extracts just the position data for the flights and contains flight ID #s
        * we currently have one large position dataframe that is 11 million rows
        * we also have individual position dataframes for each month but need to rework them as some positions have been excluded due to outliers
* metadata: codebook that describes the variables in the positions data
    * need to include other data
* results: will include statistical tables and final figures
* src: all of the source code, the programs/ functions.  Could name this differently?
    * data-cleaning: these are the functions to read in the raw data and clean it (transform to flat files, convert the time)
    * summary-stats: these are all the functions to get the results that show us something
    * unused-code: these are functions I've used in the past but are no longer as relevant.. but for which the code could at some point come in handy
* sound-study: the functions needed to manipulate and transform the sound study data
* doc: for manuscripts and documentation and lab notebook
    * Could combine this with metadata?

