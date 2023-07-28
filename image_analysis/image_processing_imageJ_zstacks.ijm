setOption("JFileChooser", true); //Mac version fails to show title
input = getDirectory("Select input directory");
output = getDirectory("Select output directory");

all_files = getFileList(input);
for (i = 0; i < all_files.length; i++) {
   cur_file = input + all_files[i];
   //for now handle 20x and 60x the same way
   if (matches(cur_file, ".+S\\d+_20[Xx]_\\d+_zstack\\.nd2$")) {
    process_image(cur_file, "20X");
   }
   else if (matches(cur_file, ".+S\\d+_60[Xx]_\\d+_zstack\\.nd2$")){
    process_image(cur_file, "60X");
   }
}

function process_image(file, magnification) {
    import_string = "open=" + file + " color_mode=Grayscale rois_import=[ROI manager] view=Hyperstack stack_order=Default";
    run("Bio-Formats Importer", import_string);
    without_extension = substring(file, 0, lengthOf(file) - 4);
    base_name = File.getName(file);
    base_name_without_extension = substring(base_name, 0, lengthOf(base_name) - 4);
    out_file = "" + output + base_name_without_extension + "_composite.tif";
    out_file_stack = "" + output + base_name_without_extension + "_composite_stack.tif";

    //break into individual colors
    selectWindow(base_name);
    run("Split Channels");

    //now run background subtraction on each
    c5 = "C5-" + base_name;
    c5_out =  "" + base_name_without_extension + "_CDKN1A.tif";
    c5_out_full_path = "" + output + c5_out;
    selectWindow(c5);
    run("Z Project...", "projection=[Max Intensity]");
    //close stack and now use z-projection window
    close(c5);
    c5 = "MAX_" + c5;
    selectWindow(c5);
    run("Subtract Background...", "rolling=20");
    if(magnification == "20X")
    {
    	setMinAndMax(0, 19661);
    }
    else if(magnification == "60X")
    {
    	setMinAndMax(0, 30000);
    }
    run("Apply LUT");
    run("Invert");
    saveAs("Tiff", c5_out_full_path);
    run("Invert");
    
    c4 = "C4-" + base_name;
    c4_out =  "" + base_name_without_extension + "_CCL2.tif";
    c4_out_full_path = "" + output + c4_out;
    selectWindow(c4);
    run("Z Project...", "projection=[Max Intensity]");
    //close stack and now use z-projection window
    close(c4);
    c4 = "MAX_" + c4;
    selectWindow(c4);
    run("Subtract Background...", "rolling=20");
    if(magnification == "20X")
    {
    	setMinAndMax(0, 22938);
    }
    else if(magnification == "60X")
    {
    	setMinAndMax(0, 40000);
    }
    run("Apply LUT");
    run("Invert");
    saveAs("Tiff", c4_out_full_path);
    run("Invert");
 
    c3 = "C3-" + base_name;
    c3_out =  "" + base_name_without_extension + "_IL1B.tif";
    c3_out_full_path = "" + output + c3_out;
    selectWindow(c3);
    run("Z Project...", "projection=[Max Intensity]");
    //close stack and now use z-projection window
    close(c3);
    c3 = "MAX_" + c3;
    selectWindow(c3);
    run("Subtract Background...", "rolling=20");
    if(magnification == "20X")
    {
    	setMinAndMax(0, 19660);
    }
    else if(magnification == "60X")
    {
    	setMinAndMax(0, 45000);
    }
    run("Apply LUT");
    run("Invert");
    saveAs("Tiff", c3_out_full_path);
    run("Invert");
 
    c2 = "C2-" + base_name;
    c2_out =  "" + base_name_without_extension + "_IBA1.tif";
    c2_out_full_path = "" + output + c2_out;
    selectWindow(c2);
    run("Z Project...", "projection=[Max Intensity]");
    //close stack and now use z-projection window
    close(c2);
    c2 = "MAX_" + c2;
    selectWindow(c2);
    run("Subtract Background...", "rolling=100");
    if(magnification == "20X")
    {
    	setMinAndMax(0, 22937);
    }
    else if(magnification == "60X")
    {
    	setMinAndMax(0, 17000);
    }
    run("Apply LUT");
    run("Invert");
    saveAs("Tiff", c2_out_full_path);
    run("Invert");
    
    c1 = "C1-" + base_name;
    c1_out =  "" + base_name_without_extension + "_DAPI.tif";
    c1_out_full_path = "" + output + c1_out;
    selectWindow(c1);
    run("Z Project...", "projection=[Max Intensity]");
    //close stack and now use z-projection window
    close(c1);
    c1 = "MAX_" + c1;
    selectWindow(c1);
    run("Subtract Background...", "rolling=50");
    if(magnification == "20X")
    {
    	setMinAndMax(0, 45875);
    }
    else if(magnification == "60X")
    {
    	setMinAndMax(0, 50000);
    }
    run("Apply LUT");
    run("Invert");
    saveAs("Tiff", c1_out_full_path);
    run("Invert");
    
    //saving changes the window names
    run_string = "" + "c1=" + c3_out + " " + "c2=" + c2_out + " " + "c3=" + c1_out + " " + "c5=" + c4_out + " " + "c6=" + c5_out + " create";
    run("Merge Channels...", run_string);
    saveAs("Tiff", out_file_stack);
    run("RGB Color");
    
    //add scale bar
    run("Scale Bar...", "width=20 height=20 thickness=10 font=48 color=White background=None location=[Lower Right] horizontal bold");
    
    //save and close
    saveAs("Tiff", out_file);
    close(out_file_stack);
    
    //RAM fills up
    run("Collect Garbage");
}