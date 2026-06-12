class aes_sequence extends uvm_sequence;
    `uvm_object_utils(aes_sequence)
    aes_sequence_item aes_sequence_item_inst;

    // Constructor
    function new(string name = "aes_sequence");
        super.new(name);
    endfunction

    // pre_body task
    task pre_body();
        aes_sequence_item_inst = aes_sequence_item::type_id::create("aes_sequence_item_inst");
    endtask
    
    // body task
    task body();

        // Start the sequence item
        start_item(aes_sequence_item_inst);

        // Randomize the inputs
        assert(aes_sequence_item_inst.randomize()) else `uvm_fatal("RAND_FAIL", "Randomization failed for aes_sequence_item");
        `uvm_info("sequence", $sformatf("Randomized sequence item with data: %h, key: %h", aes_sequence_item_inst.in, aes_sequence_item_inst.key), UVM_MEDIUM)
        // Finish the sequence item
        finish_item(aes_sequence_item_inst);
    endtask

endclass