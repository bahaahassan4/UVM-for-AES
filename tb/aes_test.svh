class aes_test extends uvm_test;
    `uvm_component_utils(aes_test)
    // Instantiation of components
    aes_env aes_env_inst;
    // Instantiation of objects
    aes_sequence aes_sequence_inst;
    // Virtual interface
    virtual aes_inf in1;

    // Constructor
    function new(string name = "aes_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    // build_phase function
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        aes_env_inst = aes_env::type_id::create("aes_env_inst", this);
        aes_sequence_inst = aes_sequence::type_id::create("aes_sequence_inst");

        if (!uvm_config_db#(virtual aes_inf)::get(this, "", "my_vif", in1)) begin
            `uvm_fatal("NOVIF", "Virtual interface not found")
        end

        uvm_config_db#(virtual aes_inf)::set(this,"aes_env_inst","my_env_vif",in1); //Should be env
        $display("Building my_test");
    endfunction

    // connect_phase function
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction

    // run_phase task
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        phase.raise_objection(this);

        `uvm_info("test", "Starting my_sequence_1", UVM_MEDIUM)
        aes_sequence_inst.start(aes_env_inst.aes_agent_inst.aes_sequencer_inst);
        `uvm_info("test", "Finished my_sequence_1", UVM_MEDIUM)

        phase.drop_objection(this);
    endtask
endclass