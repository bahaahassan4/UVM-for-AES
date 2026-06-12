class aes_env extends uvm_env;
    `uvm_component_utils(aes_env)
    // Instantiation of components
    aes_agent aes_agent_inst;
    aes_subscriber aes_subscriber_inst;
    aes_scoreboard aes_scoreboard_inst;

    // Virtual interface
    virtual aes_inf in1;

    // Constructor
    function new(string name = "aes_env", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    // build_phase function
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        aes_agent_inst = aes_agent::type_id::create("aes_agent_inst", this);
        aes_subscriber_inst = aes_subscriber::type_id::create("aes_subscriber_inst", this);
        aes_scoreboard_inst = aes_scoreboard::type_id::create("aes_scoreboard_inst", this);

        if(!uvm_config_db#(virtual aes_inf)::get(this, "", "my_env_vif", in1)) begin
            `uvm_fatal("NOVIF", "Virtual interface not found in env")
        end

        uvm_config_db#(virtual aes_inf)::set(this,"aes_agent_inst","my_agent_vif",in1); //Should be agent
    endfunction

    // connect_phase function
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        aes_agent_inst.monitor_ap.connect(aes_subscriber_inst.analysis_export);
        aes_agent_inst.monitor_ap.connect(aes_scoreboard_inst.aes_analysis_imp);
    endfunction

    // run_phase task
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
    endtask
endclass