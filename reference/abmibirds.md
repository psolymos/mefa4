# Raw Dataset of Bird Point Counts

A data set of bird point counts collected by the Alberta Biodiversity
Monitoring Institute (ABMI, https://www.abmi.ca).

## Usage

``` r
data(abmibirds)
```

## Format

A data frame with 59341 observations on the following 21 variables.

- `Rotation`:

  a factor. Reference describing when data was collected at a broad
  level. Code definition: Prototype = 2003–2006, Rotation 1 = 2007–2012

- `ABMI.Site`:

  a numeric vector. Reference number given to each ABMI data collection
  site (1–1656).

- `Year`:

  a numeric vector. Collection year.

- `Field.Date`:

  a factor. Day, month, and year data was collected.

- `Field.Crew.Members`:

  a factor. Initials for the field technicians collecting the field
  data.

- `Identification.Date`:

  a factor. Day, month, and year data was analyzed by specialist.

- `Identification.Analyst`:

  a factor. Initials for the technicians/specialists identifying the
  specimens.

- `Point.Count.Station`:

  a numeric vector. Point count station where recording was made: 9
  stations were located around each ABMI site (1–9).

- `Wind.Conditions`:

  a factor. Estimate of wind conditions on a scale of 0–5. 0 = no wind,
  1 = calm, 2 = leaves rustling, 3 small branches moving, 4 = large
  branches moving, 5 = large branches moving and the tree is swaying

- `Precipitation`:

  a factor. Classification for precipitation conditions in 5 categories.
  Input value: Drizzle, Fog, Rain, Sleet, Snow, None

- `Start.of.Point.Count`:

  a factor. Time of day recording was started. Input value: 24 hour
  clock (hh:mm).

- `End.of.Point.Count`:

  a factor. Time of day recording was finished. Input value: 24 hour
  clock (hh:mm).

- `Common.Name`:

  a factor. Common name of bird species detected during point counts.

- `Scientific.Name`:

  a factor. Scientific name of bird species detected during point count.

- `Unique.Taxonomic.Identification.Number`:

  a factor. Globally unique identifier of bird species detected during
  point count. Unique taxonomic identifiers are generally taken from the
  International Taxonomic Information System (ITIS;
  <https://www.itis.gov/>).

- `Taxonomic.Resolution`:

  a factor. Resolution to which bird species was identified (e.g.
  Family, Genus, Species etc.).

- `Time.First.Detected`:

  a factor. Approximate time the bird analyst first detects a bird
  species from the recording; listed in 10-second intervals.

- `Interval.1`:

  a factor. First time interval of the 10-minute point count (0–200
  seconds) when bird species are detected and identified.

- `Interval.2`:

  a factor. Middle time interval of the 10-minute point count (201–400
  seconds) when bird species are detected or re-detected.

- `Interval.3`:

  a factor. Last time interval of the 10-minute point count (401–600
  seconds) when bird species are detected or re-detected.

- `Behaviour`:

  a factor. Classification given to each species detection (if
  possible).

## Details

Breeding birds were measured at nine point count stations. Point count
stations were in a grid pattern with point count station no. 1 located
at site-centre and the remaining stations located 300 m apart
surrounding site centre. We conducted breeding bird surveys from one
half hour before sunrise to 10:00 hrs.

We recorded vocalizations of birds for 10 minutes at each point count
station using an omni-directional microphone (CZM microphone; River
Forks Research Corp.) mounted at ear level on a professional tripod and
connected to a mini hard drive recorder. We recorded birds on a Marantz
PM D670 or PM D660 Solid State recorder at 320 kbps in .mp3 format. We
calibrated the recorder volume to be in the mid ranges.

While conducting the 10 minute bird recordings, we scanned the areas
surrounding the point count station for all birds (even those
vocalizing), noting species, number of individuals (including flock
sizes of birds flying overhead), and distance from the point count
station, for all bird observations. We also noted factors that
potentially bias bird recordings, such as wind speed and precipitation.
Bird recordings were later analyzed by bird identification specialists
in a laboratory setting.

If a bird point fell in open water, we established a new point if we
were able to get within 100 m of the original point, recording distance
and direction from that original point. If it was not possible to get
within 100 m of the original point (i.e., \<200 m from the last point),
we conducted a 10 minute visual point count of the waterbody recording
observations into the microphone. We may not have sampled certain points
because they were inaccessible (e.g., a stream made access hazardous or
impossible).

We analyzed bird recordings in a laboratory setting. We identified the
species, time of first detection (within 10 second intervals), behaviour
(e.g., singing, calling, or alarm-calling), and the time interval that
individual birds were detected. We recognized 3 time intervals: Interval
1 (0–200 seconds), Interval 2 (201–400 seconds), and Interval 3 (401–600
seconds). Individual birds were detected in 1, 2, or 3 of the time
intervals. We identified red squirrel (*Tamiasciurus hudsonicus*)
vocalizations in addition to bird vocalizations. Bird recordings are
randomly sampled and verified by other experts in bird identification to
ensure accuracy.

Throughout ABMI raw data files, the following codes and definitions are
applied.

None or 0: None or 0 is applied to any variable that was examined by
field crews and found to be absent. None is used for text entries and 0
is used for numerical entries. For example, when field crews examine the
canopy and find no Veteran trees in the canopy, this is recorded as
None. When there is no slope at the survey site, slope is recorded as 0.
The numeral 0 can also be used as a nominal code, for example, wind
conditions can be recorded as 0.

VNA Variable Not Applicable: Some ABMI data is collected in a nested
manner. For example Tree Species is a parent variable. This variable has
a number of child variables that are used to describe the parent
variable in more detail (e.g., condition, DBH, decay stage). When the
parent variable is recorded as None, child variables are no longer
applied and are recorded as VNA. VNA is also used when the protocol
calls for a modified sampling procedure based on site conditions (e.g.,
surface substrate protocol variant for hydric site conditions). The use
of VNA implies that users of the data should not expect that any data
could be present.

DNC, Did Not Collect: DNC is used to describe variables that should have
been collected but were not. There are a number of reasons that data
might not have been collected (e.g., staff oversight, equipment failure,
safety concerns, environmental conditions, or time constraints).
Regardless of the reason data was not collected, if under ideal
conditions it should have been, the record in the data entry file reads
DNC. The use of DNC implies that users should expect the data to be
present, though it is not.

PNA, Protocol Not Available: The ABMI's protocols were, and continue to
be, implemented in a staged manner. As a result, the collection of many
variables began in years subsequent to the start of the prototype or
operational phases or where discontinued after a few years of trial.
When a variable was not collected because the protocol had yet to be
implemented by the ABMI (or was discontinued by the ABMI), the data
entry record reads PNA. This is a global constraint to the data (i.e., a
protocol was not implemented until 2006, therefore, previous years
cannot have this variable). PNA is to be used to describe the lack of
data collection for entire years.

SNI, Species Not Identified: In various fields related to species
identification, SNI is used to indicate that the organism was not
identified. Some possible reasons that identification was not possible
include insufficient or deficient sample collected and lack of field
time.

## Source

RAW_T26BreedingBirds28621.csv, https://www.abmi.ca

## References

Raw breeding bird data (2004–2006 inclusive) from the Alberta
Biodiversity Monitoring Institute was used, in whole or part, to create
this product. More information on the Institute can be found at:
https://www.abmi.ca

## Examples

``` r
data(abmibirds)
str(abmibirds)
#> 'data.frame':    59341 obs. of  21 variables:
#>  $ Rotation                              : Factor w/ 2 levels "Prototype","Rotation 1": 1 1 1 1 1 1 1 1 1 1 ...
#>  $ ABMI.Site                             : int  630 630 630 630 630 630 630 630 630 630 ...
#>  $ Year                                  : int  2003 2003 2003 2003 2003 2003 2003 2003 2003 2003 ...
#>  $ Field.Date                            : Factor w/ 132 levels "01-Jun-03","01-Jun-04",..: 46 46 46 46 46 46 46 46 46 46 ...
#>  $ Field.Crew.Members                    : Factor w/ 67 levels "ABL","ABL/RSW",..: 15 15 15 15 15 15 15 15 15 15 ...
#>  $ Identification.Date                   : Factor w/ 135 levels "01-Feb-10","01-Jun-08",..: 135 135 135 135 135 135 135 135 135 135 ...
#>  $ Identification.Analyst                : Factor w/ 13 levels "CF/CS/TH","CLS/MBI",..: 11 11 11 11 11 11 11 11 11 11 ...
#>  $ Point.Count.Station                   : int  1 1 1 1 1 1 1 1 2 2 ...
#>  $ Wind.Conditions                       : Factor w/ 7 levels "0","1","2","3",..: 4 4 4 4 4 4 4 4 4 4 ...
#>  $ Precipitation                         : Factor w/ 5 levels "DNC","Drizzle",..: 4 4 4 4 4 4 4 4 4 4 ...
#>  $ Start.of.Point.Count                  : Factor w/ 434 levels "10:00","10:01",..: 152 152 152 152 152 152 152 152 178 178 ...
#>  $ End.of.Point.Count                    : Factor w/ 42 levels "10:07","10:21",..: 42 42 42 42 42 42 42 42 42 42 ...
#>  $ Common.Name                           : Factor w/ 217 levels "Accipiters","Alder Flycatcher",..: 184 184 142 142 142 150 208 161 208 181 ...
#>  $ Scientific.Name                       : Factor w/ 218 levels "Accipiter","Accipiter gentilis",..: 207 207 173 173 173 209 201 149 201 57 ...
#>  $ Taxonomic.Resolution                  : Factor w/ 5 levels "Family","Genus",..: 3 3 3 3 3 3 3 3 3 3 ...
#>  $ Unique.Taxonomic.Identification.Number: Factor w/ 215 levels "174469","174479",..: 130 130 214 214 214 149 122 161 122 195 ...
#>  $ Time.First.Detected                   : Factor w/ 129 levels ".1",".2",".3",..: 87 97 112 87 31 40 13 68 31 13 ...
#>  $ Interval.1                            : Factor w/ 6 levels "","0","1","DNC",..: 5 5 5 5 5 5 5 5 5 5 ...
#>  $ Interval.2                            : Factor w/ 6 levels "","0","1","DNC",..: 5 5 5 5 5 5 5 5 5 5 ...
#>  $ Interval.3                            : Factor w/ 6 levels "","0","1","DNC",..: 5 5 5 5 5 5 5 5 5 5 ...
#>  $ Behaviour                             : Factor w/ 21 levels "Alarm Calling",..: 19 19 19 19 19 19 19 19 19 19 ...
```
