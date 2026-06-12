class aes_sequence_item extends uvm_sequence_item;
    `uvm_object_utils(aes_sequence_item)

    // Constructor
    function new(string name = "aes_sequence_item");
        super.new(name);
    endfunction

    // I/Os for AES operation
    // Inputs
    
    //rand logic [127:0] plaintext;
    rand logic [127:0] in;
    
    rand logic [127:0] key;

    // Outputs
    //logic [127:0] ciphertext;
    logic [127:0] out;

    // Has no constraints for now, but can be added later
endclass   