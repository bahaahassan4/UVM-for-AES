class aes_driver extends uvm_driver #(aes_sequence_item);
    `uvm_component_utils(aes_driver)
    // Instantiation of object
    aes_sequence_item aes_sequence_item_inst;
    // Virtual interface
    virtual aes_inf in1;

    // Constructor
    function new(string name = "aes_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    // build_phase function
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        aes_sequence_item_inst = aes_sequence_item::type_id::create("aes_sequence_item_inst", this);

        if(!uvm_config_db#(virtual aes_inf)::get(this, "", "my_driver_monitor_vif", in1)) begin
            `uvm_fatal("NOVIF", "Virtual interface not found in driver")
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
            seq_item_port.get_next_item(aes_sequence_item_inst);
            `uvm_info("driver", $sformatf("Received sequence item with data: %h", aes_sequence_item_inst.in), UVM_MEDIUM)
            // Drive the data to the DUT using the virtual interface
            in1.in = aes_sequence_item_inst.in;
            in1.key = aes_sequence_item_inst.key;
            #1step;
            seq_item_port.item_done();
            `uvm_info("driver", $sformatf("Recieved in virtual interface: in = %h, key = %h", in1.in, in1.key), UVM_MEDIUM)
        end
        `uvm_info("driver", "running phase", UVM_MEDIUM)
    endtask
endclass