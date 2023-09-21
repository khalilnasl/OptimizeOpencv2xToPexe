# OptimizeOpencv2xToPexe, Code Documentation

---

#### `SimplePlatooningBeaconing.cc`

- **Purpose**: To synchronize the start times for vehicles in a platoon for optimal coordination.

---

#### `SimplePlatooningBeaconingHuman.cc`

- **Purpose**: To initiate vehicle movement at random start times, occurring after a 2-second delay.

---

#### `LteMacVUeMode4.cc`
- **Key Modifications**:
  - **macHandleSps Function**: 
    1. Sorts the CSRs vector received from the PHY layer based on subframe values.
    2. Passes the `platoonSize` variable from the application layer to the MAC layer for processing.
    3. Determines whether a vehicle should employ partitioned or random selection based on its MAC ID.

---

#### `LtePhy.ned`

- **Purpose**: To collect and record metrics from the physical layer for analysis.

- **Metrics Recorded**:

  - `sciUnsensed`: Number of failed SCIs due to RSRP below threshold
  - `tbSent`: Number of Transport Block sent
  - `tbDecoded`: Number of tb Decoded
  - `tbFailedDueToProp`: Number of failed TBs due to propogation
  - `senderID`: ID of node who sent message

---

#### `HumanCar.ned`

- **Purpose**: Adds the non-platooning vehicle module within the simulation.

---

#### `omnetpp.ini`

- **Purpose**: To configure simulation settings.

- **Configuration Parameters**:

  - Uses the `PlatooningNoGui` configuration for the simulation.
  - Sets the `PlatoonSize` to 4.
  - Output file naming follows the pattern: `${configname}_${humanCars}_${repetition}.vec`

---

#### `convert_files.sh`

- **Purpose**: To convert `.vec` simulation output files to `.csv` format for easier data analysis.

- **File Naming Convention**: The converted `.csv` files follow the pattern `${method}_${Background_car_numbers}_${repetition}.csv`.

---
