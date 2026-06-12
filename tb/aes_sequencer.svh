class aes_sequencer extends uvm_sequencer #(aes_sequence_item);
    `uvm_component_utils(aes_sequencer)
    // Instantiation of object
    aes_sequence_item aes_sequence_item_inst;

    // you don't need to instantiate uvm_seq_item_pull_imp because it's already implemented in uvm_sequencer
    // Constructor
    function new(string name = "aes_sequencer", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    // build_phase function
    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        aes_sequence_item_inst = aes_sequence_item::type_id::create("aes_sequence_item_inst", this);
    endfunction

    // connect_phase function
    function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
    endfunction

    // run_phase task
    task run_phase (uvm_phase phase);
        super.run_phase(phase);
        `uvm_info("Sequencer", "running phase", UVM_MEDIUM)
    endtask
endclass