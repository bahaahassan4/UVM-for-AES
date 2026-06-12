class aes_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(aes_scoreboard)
    // Instantiation of object
    aes_sequence_item aes_sequence_item_inst;
    int fd; // file descriptor
    bit [127:0] exp_out; // expected output

    uvm_analysis_imp #(aes_sequence_item, aes_scoreboard) aes_analysis_imp;

    // Constructor
    function new(string name = "aes_scoreboard", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    // build_phase function
    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        aes_sequence_item_inst = aes_sequence_item::type_id::create("aes_sequence_item_inst", this);
        aes_analysis_imp = new("aes_analysis_imp", this);
    endfunction

    // connect_phase function
    function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
    endfunction

    // run_phase task
    task run_phase (uvm_phase phase);
        super.run_phase(phase);
    endtask

    // write task (that already implemented in uvm_scoreboard as pure virtual task)
    task write (aes_sequence_item t);
        // NOTE: MAKE SURE THE PATH TO CODE AND FILES ARE RIGHT 
        // TIP : RUN THE PYTHON CODE ON TERMINAL FROM THE DIRECTORY 
        //       OF THE UVM SCOREBOARD TO CHECK NO ERRORS
        int fd; // file descriptor
        bit [127:0] exp_out; // expected output
        // Open file "key.txt" for writing
        fd = $fopen("../Python_code/key.txt","w");

        // Writing to file : First line writing the data , Second line writing the key
        $fdisplay(fd,"%h \n%h",t.in , t.key);

        // Close the "key.txt"
        $fclose(fd);

        // "$system" task to run the python code and interact with SCOREBOARD through I/O files
        $system($sformatf("python  ./Python_code/aes_enc.py"));

        // Open file "output.txt" for reading
        fd = $fopen("../Python_code/output.txt","r");

        // Reading the output of python code through "output.txt" file
        exp_out = $fscanf(fd,"%h",exp_out);

        // Close the "output.txt"
        $fclose(fd);

        // COMPARE THE ACTUAL OUTPUT AND EXPECTED OUTPUT
        if(exp_out == t.out)
            $display("SUCCESS , OUT IS %h and EXP OUT IS %h ", t.out , exp_out);
        else 
            $display("FAILURE , OUT IS %h and EXP OUT IS %h ", t.out , exp_out);
    endtask
endclass