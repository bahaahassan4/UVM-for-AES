class aes_agent extends uvm_agent;
    `uvm_component_utils(aes_agent)
    // Instantiation of components
    aes_driver      aes_driver_inst;
    aes_monitor     aes_monitor_inst;
    aes_sequencer   aes_sequencer_inst;
    // Instantiation of object
    aes_sequence_item aes_sequence_item_inst;

    uvm_analysis_port #(aes_sequence_item) monitor_ap;

    // Virtual Interface
    virtual aes_inf in1;

    // Constructor
    function new(string name = "aes_agent", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    // build_phase function
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        aes_driver_inst = aes_driver::type_id::create("aes_driver_inst", this);
        aes_monitor_inst = aes_monitor::type_id::create("aes_monitor_inst", this);
        aes_sequencer_inst = aes_sequencer::type_id::create("aes_sequencer_inst", this);

        aes_sequence_item_inst = aes_sequence_item::type_id::create("aes_sequence_item_inst", this);

        monitor_ap = new("monitor_ap", this);
    
        if(!uvm_config_db#(virtual aes_inf)::get(this, "", "my_agent_vif", in1)) begin
            `uvm_fatal("NOVIF", "Virtual interface not found in agent")
        end

        uvm_config_db#(virtual aes_inf)::set(this,"*","my_driver_monitor_vif",in1); //Should be driver
    endfunction

    // connect_phase function
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        aes_monitor_inst.analysis_port.connect(monitor_ap);
        aes_driver_inst.seq_item_port.connect(aes_sequencer_inst.seq_item_export);
    endfunction
    
    // run_phase task
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
    endtask
endclass