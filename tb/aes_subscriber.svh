class aes_subscriber extends uvm_subscriber #(aes_sequence_item); // any class has built in port or imp must have #(type) after uvm_component
    `uvm_component_utils(aes_subscriber)
    // Instantiation of object
    aes_sequence_item aes_sequence_item_inst;

    // Constructor
    function new(string name = "aes_subscriber", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    // build_phase function
    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        aes_sequence_item_inst = aes_sequence_item::type_id::create("aes_sequence_item_inst", this);
    endfunction

    // connect_phase function
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction

    // run_phase task
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
    endtask

    // write task (that already implemented in uvm_subscriber as pure virtual task)
    function void write (aes_sequence_item t);
        `uvm_info("Subscriber", $sformatf("Subscriber write function"), UVM_LOW)
    endfunction
endclass