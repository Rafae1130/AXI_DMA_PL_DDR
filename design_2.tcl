
################################################################
# This is a generated script based on design: design_2
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2021.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_gid_msg -ssname BD::TCL -id 2041 -severity "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source design_2_script.tcl


# The design that will be created by this Tcl script contains the following 
# module references:
# bram_config, data_transfer, edge_detector, edge_detector

# Please add the sources of those modules before sourcing this Tcl script.

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xczu9eg-ffvb1156-2-e
   set_property BOARD_PART xilinx.com:zcu102:part0:3.4 [current_project]
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name design_2

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_gid_msg -ssname BD::TCL -id 2001 -severity "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_gid_msg -ssname BD::TCL -id 2002 -severity "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_gid_msg -ssname BD::TCL -id 2003 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_gid_msg -ssname BD::TCL -id 2004 -severity "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_gid_msg -ssname BD::TCL -id 2005 -severity "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_gid_msg -ssname BD::TCL -id 2006 -severity "ERROR" $errMsg}
   return $nRet
}

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:ip:axi_bram_ctrl:4.1\
xilinx.com:ip:axi_dma:7.1\
xilinx.com:ip:blk_mem_gen:8.4\
xilinx.com:ip:c_counter_binary:12.0\
xilinx.com:ip:ddr4:2.2\
user.org:user:myip:1.0\
xilinx.com:ip:proc_sys_reset:5.0\
xilinx.com:ip:system_ila:1.1\
xilinx.com:ip:vio:3.0\
xilinx.com:ip:xlconstant:1.1\
"

   set list_ips_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2011 -severity "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2012 -severity "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

##################################################################
# CHECK Modules
##################################################################
set bCheckModules 1
if { $bCheckModules == 1 } {
   set list_check_mods "\ 
bram_config\
data_transfer\
edge_detector\
edge_detector\
"

   set list_mods_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2020 -severity "INFO" "Checking if the following modules exist in the project's sources: $list_check_mods ."

   foreach mod_vlnv $list_check_mods {
      if { [can_resolve_reference $mod_vlnv] == 0 } {
         lappend list_mods_missing $mod_vlnv
      }
   }

   if { $list_mods_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2021 -severity "ERROR" "The following module(s) are not found in the project: $list_mods_missing" }
      common::send_gid_msg -ssname BD::TCL -id 2022 -severity "INFO" "Please add source files for the missing module(s) above."
      set bCheckIPsPassed 0
   }
}

if { $bCheckIPsPassed != 1 } {
  common::send_gid_msg -ssname BD::TCL -id 2023 -severity "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set ddr4_sdram_062 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddr4_rtl:1.0 ddr4_sdram_062 ]

  set user_si570_sysclk [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 user_si570_sysclk ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {300000000} \
   ] $user_si570_sysclk


  # Create ports
  set reset [ create_bd_port -dir I -type rst reset ]
  set_property -dict [ list \
   CONFIG.POLARITY {ACTIVE_HIGH} \
 ] $reset

  # Create instance: axi_bram_ctrl_0, and set properties
  set axi_bram_ctrl_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.1 axi_bram_ctrl_0 ]
  set_property -dict [ list \
   CONFIG.PROTOCOL {AXI4LITE} \
   CONFIG.SINGLE_PORT_BRAM {1} \
 ] $axi_bram_ctrl_0

  # Create instance: axi_dma_0, and set properties
  set axi_dma_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0 ]
  set_property -dict [ list \
   CONFIG.c_enable_multi_channel {0} \
   CONFIG.c_include_mm2s_dre {0} \
   CONFIG.c_include_sg {1} \
   CONFIG.c_mm2s_burst_size {256} \
   CONFIG.c_s2mm_burst_size {256} \
   CONFIG.c_sg_include_stscntrl_strm {0} \
   CONFIG.c_sg_length_width {26} \
   CONFIG.c_single_interface {0} \
 ] $axi_dma_0

  # Create instance: axi_interconnect_0, and set properties
  set axi_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_0 ]
  set_property -dict [ list \
   CONFIG.ENABLE_ADVANCED_OPTIONS {1} \
   CONFIG.M00_HAS_DATA_FIFO {1} \
   CONFIG.M00_HAS_REGSLICE {3} \
   CONFIG.M01_HAS_DATA_FIFO {1} \
   CONFIG.M01_HAS_REGSLICE {3} \
   CONFIG.NUM_MI {2} \
   CONFIG.NUM_SI {3} \
   CONFIG.S00_ARB_PRIORITY {0} \
   CONFIG.S00_HAS_DATA_FIFO {2} \
   CONFIG.S00_HAS_REGSLICE {3} \
   CONFIG.S01_HAS_DATA_FIFO {2} \
   CONFIG.S02_ARB_PRIORITY {15} \
   CONFIG.S02_HAS_DATA_FIFO {2} \
   CONFIG.STRATEGY {2} \
 ] $axi_interconnect_0

  # Create instance: axi_interconnect_1, and set properties
  set axi_interconnect_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_1 ]
  set_property -dict [ list \
   CONFIG.ENABLE_ADVANCED_OPTIONS {1} \
   CONFIG.NUM_MI {1} \
   CONFIG.NUM_SI {2} \
   CONFIG.S00_ARB_PRIORITY {0} \
   CONFIG.S00_HAS_DATA_FIFO {2} \
   CONFIG.S01_ARB_PRIORITY {15} \
   CONFIG.S01_HAS_DATA_FIFO {2} \
   CONFIG.STRATEGY {2} \
 ] $axi_interconnect_1

  # Create instance: blk_mem_gen_0, and set properties
  set blk_mem_gen_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 blk_mem_gen_0 ]
  set_property -dict [ list \
   CONFIG.Byte_Size {9} \
   CONFIG.EN_SAFETY_CKT {false} \
   CONFIG.Enable_32bit_Address {false} \
   CONFIG.Enable_A {Always_Enabled} \
   CONFIG.Enable_B {Always_Enabled} \
   CONFIG.Load_Init_File {false} \
   CONFIG.Memory_Type {True_Dual_Port_RAM} \
   CONFIG.Port_B_Clock {100} \
   CONFIG.Port_B_Enable_Rate {100} \
   CONFIG.Port_B_Write_Rate {50} \
   CONFIG.Register_PortA_Output_of_Memory_Primitives {false} \
   CONFIG.Register_PortB_Output_of_Memory_Primitives {false} \
   CONFIG.Use_Byte_Write_Enable {false} \
   CONFIG.Use_RSTA_Pin {false} \
   CONFIG.Use_RSTB_Pin {false} \
   CONFIG.Write_Depth_A {2048} \
   CONFIG.use_bram_block {Stand_Alone} \
 ] $blk_mem_gen_0

  # Create instance: bram_config_0, and set properties
  set block_name bram_config
  set block_cell_name bram_config_0
  if { [catch {set bram_config_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $bram_config_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: c_counter_binary_0, and set properties
  set c_counter_binary_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:c_counter_binary:12.0 c_counter_binary_0 ]
  set_property -dict [ list \
   CONFIG.CE {true} \
   CONFIG.Output_Width {32} \
   CONFIG.SCLR {false} \
   CONFIG.Sync_Threshold_Output {false} \
   CONFIG.Threshold_Value {ff} \
 ] $c_counter_binary_0

  # Create instance: data_transfer_0, and set properties
  set block_name data_transfer
  set block_cell_name data_transfer_0
  if { [catch {set data_transfer_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $data_transfer_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.DATA_WIDTH {32} \
 ] $data_transfer_0

  # Create instance: ddr4_0, and set properties
  set ddr4_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:ddr4:2.2 ddr4_0 ]
  set_property -dict [ list \
   CONFIG.ADDN_UI_CLKOUT1_FREQ_HZ {500} \
   CONFIG.C0.DDR4_AxiArbitrationScheme {WRITE_PRIORITY} \
   CONFIG.C0.DDR4_AxiIDWidth {32} \
   CONFIG.C0.DDR4_AxiNarrowBurst {false} \
   CONFIG.C0_CLOCK_BOARD_INTERFACE {user_si570_sysclk} \
   CONFIG.C0_DDR4_BOARD_INTERFACE {ddr4_sdram_062} \
   CONFIG.RESET_BOARD_INTERFACE {reset} \
 ] $ddr4_0

  # Create instance: edge_detector_0, and set properties
  set block_name edge_detector
  set block_cell_name edge_detector_0
  if { [catch {set edge_detector_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $edge_detector_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: edge_detector_1, and set properties
  set block_name edge_detector
  set block_cell_name edge_detector_1
  if { [catch {set edge_detector_1 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $edge_detector_1 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: myip_0, and set properties
  set myip_0 [ create_bd_cell -type ip -vlnv user.org:user:myip:1.0 myip_0 ]
  set_property -dict [ list \
   CONFIG.C_M00_AXI_START_DATA_VALUE {0x00000000} \
   CONFIG.C_M00_AXI_TARGET_SLAVE_BASE_ADDR {0xA001001C} \
   CONFIG.C_M00_AXI_TRANSACTIONS_NUM {14} \
 ] $myip_0

  # Create instance: myip_1, and set properties
  set myip_1 [ create_bd_cell -type ip -vlnv user.org:user:myip:1.0 myip_1 ]
  set_property -dict [ list \
   CONFIG.C_M00_AXI_START_DATA_VALUE {0xA0010200} \
   CONFIG.C_M00_AXI_TARGET_SLAVE_BASE_ADDR {0xA0000010} \
   CONFIG.C_M00_AXI_TRANSACTIONS_NUM {2} \
 ] $myip_1

  # Create instance: proc_sys_reset_0, and set properties
  set proc_sys_reset_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_0 ]
  set_property -dict [ list \
   CONFIG.RESET_BOARD_INTERFACE {reset} \
   CONFIG.USE_BOARD_FLOW {true} \
 ] $proc_sys_reset_0

  # Create instance: rst_ddr4_0_300M, and set properties
  set rst_ddr4_0_300M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_ddr4_0_300M ]

  # Create instance: system_ila_0, and set properties
  set system_ila_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:system_ila:1.1 system_ila_0 ]
  set_property -dict [ list \
   CONFIG.C_DATA_DEPTH {16384} \
   CONFIG.C_MON_TYPE {MIX} \
   CONFIG.C_NUM_MONITOR_SLOTS {9} \
   CONFIG.C_NUM_OF_PROBES {18} \
   CONFIG.C_SLOT {8} \
   CONFIG.C_SLOT_1_INTF_TYPE {xilinx.com:interface:bram_rtl:1.0} \
   CONFIG.C_SLOT_2_INTF_TYPE {xilinx.com:interface:axis_rtl:1.0} \
   CONFIG.C_SLOT_3_INTF_TYPE {xilinx.com:interface:aximm_rtl:1.0} \
   CONFIG.C_SLOT_8_INTF_TYPE {xilinx.com:interface:axis_rtl:1.0} \
 ] $system_ila_0

  # Create instance: vio_0, and set properties
  set vio_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:vio:3.0 vio_0 ]
  set_property -dict [ list \
   CONFIG.C_EN_PROBE_IN_ACTIVITY {0} \
   CONFIG.C_NUM_PROBE_IN {0} \
 ] $vio_0

  # Create instance: vio_1, and set properties
  set vio_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:vio:3.0 vio_1 ]
  set_property -dict [ list \
   CONFIG.C_EN_PROBE_IN_ACTIVITY {0} \
   CONFIG.C_NUM_PROBE_IN {0} \
 ] $vio_1

  # Create instance: vio_2, and set properties
  set vio_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:vio:3.0 vio_2 ]
  set_property -dict [ list \
   CONFIG.C_EN_PROBE_IN_ACTIVITY {0} \
   CONFIG.C_NUM_PROBE_IN {0} \
 ] $vio_2

  # Create instance: vio_3, and set properties
  set vio_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:vio:3.0 vio_3 ]
  set_property -dict [ list \
   CONFIG.C_EN_PROBE_IN_ACTIVITY {0} \
   CONFIG.C_NUM_PROBE_IN {0} \
   CONFIG.C_PROBE_OUT0_WIDTH {26} \
 ] $vio_3

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {15} \
   CONFIG.CONST_WIDTH {4} \
 ] $xlconstant_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn [get_bd_intf_pins axi_bram_ctrl_0/BRAM_PORTA] [get_bd_intf_pins blk_mem_gen_0/BRAM_PORTB]
connect_bd_intf_net -intf_net [get_bd_intf_nets Conn] [get_bd_intf_pins axi_bram_ctrl_0/BRAM_PORTA] [get_bd_intf_pins system_ila_0/SLOT_1_BRAM]
connect_bd_intf_net -intf_net axi_dma_0_M_AXIS_MM2S [get_bd_intf_pins axi_dma_0/M_AXIS_MM2S] [get_bd_intf_pins system_ila_0/SLOT_8_AXIS]
  connect_bd_intf_net -intf_net axi_dma_0_M_AXI_MM2S [get_bd_intf_pins axi_dma_0/M_AXI_MM2S] [get_bd_intf_pins axi_interconnect_1/S00_AXI]
connect_bd_intf_net -intf_net [get_bd_intf_nets axi_dma_0_M_AXI_MM2S] [get_bd_intf_pins axi_dma_0/M_AXI_MM2S] [get_bd_intf_pins system_ila_0/SLOT_5_AXI]
  connect_bd_intf_net -intf_net axi_dma_0_M_AXI_S2MM [get_bd_intf_pins axi_dma_0/M_AXI_S2MM] [get_bd_intf_pins axi_interconnect_1/S01_AXI]
  connect_bd_intf_net -intf_net axi_dma_0_M_AXI_SG [get_bd_intf_pins axi_dma_0/M_AXI_SG] [get_bd_intf_pins axi_interconnect_0/S01_AXI]
connect_bd_intf_net -intf_net [get_bd_intf_nets axi_dma_0_M_AXI_SG] [get_bd_intf_pins axi_dma_0/M_AXI_SG] [get_bd_intf_pins system_ila_0/SLOT_4_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M00_AXI [get_bd_intf_pins axi_dma_0/S_AXI_LITE] [get_bd_intf_pins axi_interconnect_0/M00_AXI]
connect_bd_intf_net -intf_net [get_bd_intf_nets axi_interconnect_0_M00_AXI] [get_bd_intf_pins axi_interconnect_0/M00_AXI] [get_bd_intf_pins system_ila_0/SLOT_0_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M01_AXI [get_bd_intf_pins axi_bram_ctrl_0/S_AXI] [get_bd_intf_pins axi_interconnect_0/M01_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_1_M00_AXI [get_bd_intf_pins axi_interconnect_1/M00_AXI] [get_bd_intf_pins ddr4_0/C0_DDR4_S_AXI]
connect_bd_intf_net -intf_net [get_bd_intf_nets axi_interconnect_1_M00_AXI] [get_bd_intf_pins ddr4_0/C0_DDR4_S_AXI] [get_bd_intf_pins system_ila_0/SLOT_7_AXI]
  connect_bd_intf_net -intf_net ddr4_0_C0_DDR4 [get_bd_intf_ports ddr4_sdram_062] [get_bd_intf_pins ddr4_0/C0_DDR4]
  connect_bd_intf_net -intf_net myip_0_M00_AXI [get_bd_intf_pins axi_interconnect_0/S00_AXI] [get_bd_intf_pins myip_0/M00_AXI]
connect_bd_intf_net -intf_net [get_bd_intf_nets myip_0_M00_AXI] [get_bd_intf_pins myip_0/M00_AXI] [get_bd_intf_pins system_ila_0/SLOT_6_AXI]
  connect_bd_intf_net -intf_net myip_1_M00_AXI [get_bd_intf_pins axi_interconnect_0/S02_AXI] [get_bd_intf_pins myip_1/M00_AXI]
  connect_bd_intf_net -intf_net user_si570_sysclk_1 [get_bd_intf_ports user_si570_sysclk] [get_bd_intf_pins ddr4_0/C0_SYS_CLK]

  # Create port connections
  connect_bd_net -net Net [get_bd_pins axi_dma_0/m_axi_s2mm_aclk] [get_bd_pins axi_interconnect_0/S02_ACLK] [get_bd_pins axi_interconnect_1/S01_ACLK] [get_bd_pins c_counter_binary_0/CLK] [get_bd_pins data_transfer_0/clk] [get_bd_pins ddr4_0/addn_ui_clkout1] [get_bd_pins edge_detector_1/clk] [get_bd_pins myip_1/m00_axi_aclk] [get_bd_pins vio_2/clk] [get_bd_pins vio_3/clk]
  connect_bd_net -net axi_dma_0_s_axis_s2mm_tready [get_bd_pins axi_dma_0/s_axis_s2mm_tready] [get_bd_pins c_counter_binary_0/CE] [get_bd_pins data_transfer_0/m_axis_tready] [get_bd_pins system_ila_0/SLOT_2_AXIS_tready]
  connect_bd_net -net bram_config_0_bram_addr [get_bd_pins blk_mem_gen_0/addra] [get_bd_pins bram_config_0/bram_addr]
  connect_bd_net -net bram_config_0_bram_din [get_bd_pins blk_mem_gen_0/dina] [get_bd_pins bram_config_0/bram_din]
  connect_bd_net -net bram_config_0_bram_we [get_bd_pins blk_mem_gen_0/wea] [get_bd_pins bram_config_0/bram_we]
  connect_bd_net -net c_counter_binary_0_Q [get_bd_pins c_counter_binary_0/Q] [get_bd_pins data_transfer_0/data_in] [get_bd_pins system_ila_0/probe12]
  connect_bd_net -net data_transfer_0_m_axis_tdata [get_bd_pins axi_dma_0/s_axis_s2mm_tdata] [get_bd_pins data_transfer_0/m_axis_tdata] [get_bd_pins system_ila_0/SLOT_2_AXIS_tdata]
  connect_bd_net -net data_transfer_0_m_axis_tlast [get_bd_pins axi_dma_0/s_axis_s2mm_tlast] [get_bd_pins data_transfer_0/m_axis_tlast] [get_bd_pins myip_1/m00_axi_init_axi_txn] [get_bd_pins system_ila_0/SLOT_2_AXIS_tlast]
  connect_bd_net -net data_transfer_0_m_axis_tvalid [get_bd_pins axi_dma_0/s_axis_s2mm_tvalid] [get_bd_pins data_transfer_0/m_axis_tvalid] [get_bd_pins system_ila_0/SLOT_2_AXIS_tvalid]
  connect_bd_net -net ddr4_0_c0_ddr4_ui_clk [get_bd_pins axi_bram_ctrl_0/s_axi_aclk] [get_bd_pins axi_dma_0/m_axi_mm2s_aclk] [get_bd_pins axi_dma_0/m_axi_sg_aclk] [get_bd_pins axi_dma_0/s_axi_lite_aclk] [get_bd_pins axi_interconnect_0/ACLK] [get_bd_pins axi_interconnect_0/M00_ACLK] [get_bd_pins axi_interconnect_0/M01_ACLK] [get_bd_pins axi_interconnect_0/S00_ACLK] [get_bd_pins axi_interconnect_0/S01_ACLK] [get_bd_pins axi_interconnect_1/ACLK] [get_bd_pins axi_interconnect_1/M00_ACLK] [get_bd_pins axi_interconnect_1/S00_ACLK] [get_bd_pins blk_mem_gen_0/clka] [get_bd_pins bram_config_0/clk] [get_bd_pins ddr4_0/c0_ddr4_ui_clk] [get_bd_pins edge_detector_0/clk] [get_bd_pins myip_0/m00_axi_aclk] [get_bd_pins proc_sys_reset_0/slowest_sync_clk] [get_bd_pins rst_ddr4_0_300M/slowest_sync_clk] [get_bd_pins system_ila_0/clk] [get_bd_pins vio_0/clk] [get_bd_pins vio_1/clk]
  connect_bd_net -net ddr4_0_c0_ddr4_ui_clk_sync_rst [get_bd_pins ddr4_0/c0_ddr4_ui_clk_sync_rst] [get_bd_pins rst_ddr4_0_300M/ext_reset_in]
  connect_bd_net -net edge_detector_0_pulse_out [get_bd_pins edge_detector_0/pulse_out] [get_bd_pins myip_0/m00_axi_init_axi_txn] [get_bd_pins system_ila_0/probe0]
  connect_bd_net -net edge_detector_1_pulse_out [get_bd_pins data_transfer_0/start] [get_bd_pins edge_detector_1/pulse_out] [get_bd_pins system_ila_0/probe5]
  connect_bd_net -net reset_1 [get_bd_ports reset] [get_bd_pins ddr4_0/sys_rst] [get_bd_pins proc_sys_reset_0/ext_reset_in]
  connect_bd_net -net rst_ddr4_0_300M_peripheral_aresetn [get_bd_pins ddr4_0/c0_ddr4_aresetn] [get_bd_pins rst_ddr4_0_300M/peripheral_aresetn]
  connect_bd_net -net util_vector_logic_0_Res [get_bd_pins axi_bram_ctrl_0/s_axi_aresetn] [get_bd_pins axi_dma_0/axi_resetn] [get_bd_pins axi_interconnect_0/ARESETN] [get_bd_pins axi_interconnect_0/M00_ARESETN] [get_bd_pins axi_interconnect_0/M01_ARESETN] [get_bd_pins axi_interconnect_0/S00_ARESETN] [get_bd_pins axi_interconnect_0/S01_ARESETN] [get_bd_pins axi_interconnect_0/S02_ARESETN] [get_bd_pins axi_interconnect_1/ARESETN] [get_bd_pins axi_interconnect_1/M00_ARESETN] [get_bd_pins axi_interconnect_1/S00_ARESETN] [get_bd_pins axi_interconnect_1/S01_ARESETN] [get_bd_pins data_transfer_0/resetn] [get_bd_pins edge_detector_0/rst] [get_bd_pins edge_detector_1/rst] [get_bd_pins myip_0/m00_axi_aresetn] [get_bd_pins myip_1/m00_axi_aresetn] [get_bd_pins proc_sys_reset_0/peripheral_aresetn] [get_bd_pins system_ila_0/resetn]
  connect_bd_net -net vio_0_probe_out0 [get_bd_pins edge_detector_0/signal_in] [get_bd_pins vio_0/probe_out0]
  connect_bd_net -net vio_1_probe_out0 [get_bd_pins bram_config_0/rst] [get_bd_pins system_ila_0/probe11] [get_bd_pins vio_1/probe_out0]
  connect_bd_net -net vio_2_probe_out0 [get_bd_pins edge_detector_1/signal_in] [get_bd_pins vio_2/probe_out0]
  connect_bd_net -net vio_3_probe_out0 [get_bd_pins bram_config_0/transfer_len] [get_bd_pins data_transfer_0/count] [get_bd_pins system_ila_0/probe1] [get_bd_pins vio_3/probe_out0]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins axi_dma_0/s_axis_s2mm_tkeep] [get_bd_pins data_transfer_0/valid_in] [get_bd_pins xlconstant_0/dout]

  # Create address segments
  assign_bd_address -offset 0xA0010000 -range 0x00002000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_SG] [get_bd_addr_segs axi_bram_ctrl_0/S_AXI/Mem0] -force
  assign_bd_address -offset 0x80000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs ddr4_0/C0_DDR4_MEMORY_MAP/C0_DDR4_ADDRESS_BLOCK] -force
  assign_bd_address -offset 0x80000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs ddr4_0/C0_DDR4_MEMORY_MAP/C0_DDR4_ADDRESS_BLOCK] -force
  assign_bd_address -offset 0xA0010000 -range 0x00002000 -target_address_space [get_bd_addr_spaces myip_0/M00_AXI] [get_bd_addr_segs axi_bram_ctrl_0/S_AXI/Mem0] -force
  assign_bd_address -offset 0xA0000000 -range 0x00010000 -target_address_space [get_bd_addr_spaces myip_0/M00_AXI] [get_bd_addr_segs axi_dma_0/S_AXI_LITE/Reg] -force
  assign_bd_address -offset 0xA0010000 -range 0x00002000 -target_address_space [get_bd_addr_spaces myip_1/M00_AXI] [get_bd_addr_segs axi_bram_ctrl_0/S_AXI/Mem0] -force
  assign_bd_address -offset 0xA0000000 -range 0x00010000 -target_address_space [get_bd_addr_spaces myip_1/M00_AXI] [get_bd_addr_segs axi_dma_0/S_AXI_LITE/Reg] -force

  # Exclude Address Segments
  exclude_bd_addr_seg -offset 0xA0000000 -range 0x00010000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_SG] [get_bd_addr_segs axi_dma_0/S_AXI_LITE/Reg]


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


