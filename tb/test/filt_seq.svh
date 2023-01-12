// Sequence that is sent to driver
class filt_seq extends uvm_sequence #(filt_seq_item);

	// UVM Factory Registration Macro
	`uvm_object_utils(filt_seq)

	// Standard Methods
	extern function new(string name = "filt_seq");
	extern task body;

endclass: filt_seq

function filt_seq::new(string name = "filt_seq");
	super.new(name);
endfunction

task filt_seq::body();
	filt_seq_item item;
	begin
		item = filt_seq_item::type_id::create("item");
      	repeat(500) begin
			start_item(item);
			item.randomize();
			finish_item(item);
		end
	end
endtask