# Protocol_DV
This is simple memory testbench using sv/uvm.

OVERVIEW
This project implements a UVM-based verification environment for a simple memory model.
The testbench verifies basic read and write operations, ensuring data integrity and proper protocol handling.

FEATURES
UVM Testbench architecture:

Driver – Sends read/write transactions to the DUT.

Sequencer – Controls transaction flow.

Monitor – Captures DUT interface activity for checking and coverage.

Scoreboard – Compares expected and actual data.

Configurable memory size.

Support for both directed and random tests.

Coverage collection for address and data patterns.

HOW IT WORKS
DUT – A simple synchronous memory with configurable depth and width.

Sequence – Generates read/write transactions with random or fixed addresses and data.

Driver – Converts sequence items into DUT signal-level activity.

Monitor – Observes transactions and forwards them to the scoreboard.

Scoreboard – Stores expected memory state and checks against DUT responses.
