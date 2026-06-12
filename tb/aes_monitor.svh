class aes_monitor extends uvm_monitor;
    `uvm_component_utils(aes_monitor)
    // Instantiation of object
    aes_sequence_item aes_sequence_item_inst;
    // Virtual interface
    virtual aes_inf in1;
    // Define port for TLM
    uvm_analysis_port#(aes_sequence_item) analysis_port;

    // Constructor
    function new(string name = "aes_monitor", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    // build_phase function
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        aes_sequence_item_inst = aes_sequence_item::type_id::create("aes_sequence_item_inst", this);

        analysis_port = new("analysis_port",this);

        if(!uvm_config_db#(virtual aes_inf)::get(this, "", "my_driver_monitor_vif", in1)) begin
            `uvm_fatal("NOVIF", "Virtual interface not found in monitor")
        end
    endfunction

    // connect_phase function
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction
    
    // run_phase task
    task run_phase(uvm_phase phase);
        super.run_phase(phase);

        forever begin
            #1;
            aes_sequence_item_inst.in = in1.in;
            aes_sequence_item_inst.key = in1.key;
            aes_sequence_item_inst.out = in1.out;

            #1step analysis_port.write(aes_sequence_item_inst);

            `uvm_info("Monitor", $sformatf("Monitor read values : IN = %h , KEY = %h , OUT = %h", aes_sequence_item_inst.in, aes_sequence_item_inst.key, aes_sequence_item_inst.out), UVM_LOW)
        end
    endtask
endclass