

##This task was programmed by Gilles Dutilh


##If you use this task please refer to:
#Forstmann, B.U., Dutilh, G., Brown, S., Neumann, J., 
#von Cramon, D.Y., Ridderinkhof, K.R. & Wagenmakers, E.J. (2008). 
#Striatum and pre-SMA facilitate decision-making under time pressure. 
#Proceedings of the National Academy of Sciences, 105 (45), 17538-17542.

#################
# changed by Iris Proff, January 2018

# updated with more port codes, j.g.wijnen, 18 april 2011

# updated with variable cue duration and fixed cue-target interval, LvM251011

# Extensively updated and rewritten: Hedderik van Rijn, 111112.

##################
#
# PORT CODES
# 10: blank onset
# 20: control cue onset
# 30: left cue onset
# 40: right cue onset
# 50: md onset left
# 60: md onset right
# 70: break onset
# 80: arrows onset
# 90: Pre feedback blank 
# 100: Feedback onset
# 110: New block

#####################################
#				SET BUTTONS #
#####################################

response_port_output = false;

write_codes = false; # if true, then an output port has to be present - LvM251011

active_buttons 	= 5;
button_codes = 1,2,3,4,5;
response_matching = simple_matching;

#####################################
#				BEGIN SDL			#
#####################################

begin;

#####################################
#				MAKING PICTURES		#
#####################################

# Fixation crosses during dot motion
box { height = 3; width = 51; color = 181,181,180; } fix_horiz_w;
box { height = 51; width = 3; color = 181,181,180; } fix_vert_w;

box { height = 3; width = 51; color = 255,100,255; } fix_horiz_r;
box { height = 51; width = 3; color = 255,100,255; } fix_vert_r;

box { height = 3; width = 51; color = 0,245,0; } fix_horiz_g;
box { height = 51; width = 3; color = 0,245,0; } fix_vert_g;

arrow_graphic {
   coordinates = 40, 0, -40, 0;
   line_width = 5;
   head_width = 20;
   head_length = 20;
}arrow_left;

arrow_graphic {
   coordinates = -40, 0, 40, 0;
   line_width = 5;
   head_width = 20;
   head_length = 20;
}arrow_right;

picture {
	arrow_graphic arrow_left; x = -100; y = 150;
	arrow_graphic arrow_right; x = 100; y = 0;
	arrow_graphic arrow_left; x = -100; y = -150;
	arrow_graphic arrow_right; x = 100; y = -150;
	box fix_horiz_r; x=0; y=150;
	box fix_vert_r;  x=0; y=150;
	box fix_horiz_g; x=0; y=0;
	box fix_vert_g;  x=0; y=0;
	box fix_horiz_w; x=0; y=-150;
	box fix_vert_w;  x=0; y=-150;
} boxes_c1;

picture {
	arrow_graphic arrow_left; x = -100; y = 150;
	arrow_graphic arrow_right; x = 100; y = 0;
	arrow_graphic arrow_left; x = -100; y = -150;
	arrow_graphic arrow_right; x = 100; y = -150;
	box fix_horiz_g; x=0; y=150;
	box fix_vert_g;  x=0; y=150;
	box fix_horiz_r; x=0; y=0;
	box fix_vert_r;  x=0; y=0;
	box fix_horiz_w; x=0; y=-150;
	box fix_vert_w;  x=0; y=-150;
} boxes_c2;

box  
	{
	width=3;height=3;
	color=255,255,255;
	} dot;

# PICTURES FOR THE "MOVIE" OF MOVING DOTS, EACH PIC IS STILL EMPTY
array{
	picture {} p1; 	picture {} p2; 	picture {} p3;  picture {} p4; 	picture {} p5; 	picture {} p6; 
	picture {} p7; 	picture {} p8; 	picture {} p9;  picture {} p10; 	picture {} p11; 	picture {} p12;
	picture {} p13; 	picture {} p14;	picture {} p15; picture {} p16; 	picture {} p17; 	picture {} p18;
	picture {} p19;	picture {} p20;	picture {} p21; picture {} p22;	picture {} p23;	picture {} p24;
	picture {} p25;	picture {} p26;	picture {} p27; picture {} p28; 	picture {} p29;	picture {} p30;
	picture {} p31; 	picture {} p32; 	picture {} p33; picture {} p34; 	picture {} p35; 	picture {} p36; 
	picture {} p37; 	picture {} p38; 	picture {} p39; picture {} p40; 	picture {} p41; 	picture {} p42;
	picture {} p43; 	picture {} p44;	picture {} p45; picture {} p46; 	picture {} p47; 	picture {} p48;
	picture {} p49;	picture {} p50;	picture {} p51; picture {} p52;	picture {} p53;	picture {} p54;
	picture {} p55;	picture {} p56;	picture {} p57; picture {} p58; 	picture {} p59;	picture {} p60;
	picture {} p61; 	picture {} p62; 	picture {} p63; picture {} p64; 	picture {} p65; 	picture {} p66; 
	picture {} p67; 	picture {} p68; 	picture {} p69; picture {} p70; 	picture {} p71; 	picture {} p72;
	picture {} p73; 	picture {} p74;	picture {} p75; picture {} p76; 	picture {} p77; 	picture {} p78;
	picture {} p79;	picture {} p80;	picture {} p81; picture {} p82;	picture {} p83;	picture {} p84;
	picture {} p85;	picture {} p86;	picture {} p87; picture {} p88; 	picture {} p89;	picture {} p90;

}movdot_pics;


# PICTURE THAT CONTAINS THE TEXT FOR THE FEEDBACK

picture {
			text
				{
				caption=" ";
				font_size=28;
				} feedback;
				x=0; y=0;  						
} feedback_pic;			

picture {
			text
				{
				caption=" ";
				font_size=28;
				} empty_text;
				x=0; y=25;
} empty_pic;

#####################################
#				MAKING TRIALs				#
#####################################

trial { # info trial for breaks and end of experiment
	trial_type=first_response;
	trial_duration=forever;
	picture {	
		text {
			caption="infotext";
			font_size=28;
	   }info1;
		x=0;y=0;
	}info1_pic;
	code = "Break";
	port_code = 70; 
}info1_trial;

trial{ # show arrows (condition 1)
	trial_type = first_response;
	trial_duration = forever;
	stimulus_event{
		picture boxes_c1;
		code = "Boxes";
		port_code = 80;
		#duration = 2000;
	}dirboxes_1;
}dir_boxes_1;

trial{ # show arrows (condition 2)
	trial_type = first_response;
	trial_duration = forever;
	stimulus_event{
		picture boxes_c2;
		code = "Boxes";
		port_code = 80;
		#duration = 2000;
	}dirboxes_2;
}dir_boxes_2;

trial{ # blank trial
	trial_duration = stimuli_length;
	trial_type = fixed;	
	stimulus_event{
		picture empty_pic;
		time=0;
		code="Blank";
		response_active=true;
		port_code=10;
	}blank;
}blank_trial;

trial{ # pre trial: pre cue (blank), cue (static dots + cross)
	trial_duration = stimuli_length;
	trial_type = fixed;
	stimulus_event{ # show first frame
		picture p1;
		time=0;
		code="Cue";
		port_code=20;
		response_active=true;
	}cue;
}cuetrial;

trial{ # MD trial
	trial_type=first_response;
	trial_duration = 2000;
	stimulus_event {
		picture p2;	
		delta_time=0;
		duration = 50;
		code="First";
		response_active=true;
		target_button=2;
		stimulus_time_in=0;
		port_code=50;
	}first_md_e;
	
   picture p3;delta_time= 50;duration = 50;code="3";
	picture p4;delta_time= 50;duration = 50;code="4";	   picture p5;delta_time= 50;duration = 50;code="5";
	picture p6;delta_time= 50;duration = 50;code="6";	   picture p7;delta_time= 50;duration = 50;code="7";
	picture p8;delta_time= 50;duration = 50;code="8";	   picture p9;delta_time= 50;duration = 50;code="9";
	picture p10;delta_time= 50;duration = 50;code="10";	picture p11;delta_time= 50;duration = 50;code="11";
	picture p12;delta_time= 50;duration = 50;code="12";	picture p13;delta_time= 50;duration = 50;code="13";
	picture p14;delta_time= 50;duration = 50;code="14";	picture p15;delta_time= 50;duration = 50;code="15";
	picture p16;delta_time= 50;duration = 50;code="16";	picture p17;delta_time= 50;duration = 50;code="17";
	picture p18;delta_time= 50;duration = 50;code="18";	picture p19;delta_time= 50;duration = 50;code="19";
	picture p20;delta_time= 50;duration = 50;code="20";	picture p21;delta_time= 50;duration = 50;code="21";
	picture p22;delta_time= 50;duration = 50;code="22";	picture p23;delta_time= 50;duration = 50;code="23";
	picture p24;delta_time= 50;duration = 50;code="24";	picture p25;delta_time= 50;duration = 50;code="25";
	picture p26;delta_time= 50;duration = 50;code="26";	picture p27;delta_time= 50;duration = 50;code="27";
	picture p28;delta_time= 50;duration = 50;code="28";	picture p29;delta_time= 50;duration = 50;code="29";
	picture p30;delta_time= 50;duration = 50;code="30";   picture p31;delta_time= 50;duration = 50;code="31";
	picture p32;delta_time= 50;duration = 50;code="32";	picture p33;delta_time= 50;duration = 50;code="33";
	picture p34;delta_time= 50;duration = 50;code="34";	picture p35;delta_time= 50;duration = 50;code="35";
	picture p36;delta_time= 50;duration = 50;code="36";	picture p37;delta_time= 50;duration = 50;code="37";
	picture p38;delta_time= 50;duration = 50;code="38";	picture p39;delta_time= 50;duration = 50;code="39";
	picture p40;delta_time= 50;duration = 50;code="40";	picture p41;delta_time= 50;duration = 50;code="41";
	picture p42;delta_time= 50;duration = 50;code="42";	picture p43;delta_time= 50;duration = 50;code="43";
	picture p44;delta_time= 50;duration = 50;code="44";	picture p45;delta_time= 50;duration = 50;code="45";
	picture p46;delta_time= 50;duration = 50;code="46";	picture p47;delta_time= 50;duration = 50;code="47";
	picture p48;delta_time= 50;duration = 50;code="48";	picture p49;delta_time= 50;duration = 50;code="49";
	picture p50;delta_time= 50;duration = 50;code="50";   picture p51;delta_time= 50;duration = 50;code="51";
	picture p52;delta_time= 50;duration = 50;code="52";	picture p53;delta_time= 50;duration = 50;code="53";
	picture p54;delta_time= 50;duration = 50;code="54";	picture p55;delta_time= 50;duration = 50;code="55";
	picture p56;delta_time= 50;duration = 50;code="56";	picture p57;delta_time= 50;duration = 50;code="57";
	picture p58;delta_time= 50;duration = 50;code="58";	picture p59;delta_time= 50;duration = 50;code="59";
	picture p60;delta_time= 50;duration = 50;code="60";	picture p61;delta_time= 50;duration = 50;code="61";
	picture p62;delta_time= 50;duration = 50;code="62";	picture p63;delta_time= 50;duration = 50;code="63";
	picture p64;delta_time= 50;duration = 50;code="64";	picture p65;delta_time= 50;duration = 50;code="65";
	picture p66;delta_time= 50;duration = 50;code="66";	picture p67;delta_time= 50;duration = 50;code="67";
	picture p68;delta_time= 50;duration = 50;code="68";	picture p69;delta_time= 50;duration = 50;code="69";
	picture p70;delta_time= 50;duration = 50;code="70";	picture p71;delta_time= 50;duration = 50;code="71";
	picture p72;delta_time= 50;duration = 50;code="72";	picture p73;delta_time= 50;duration = 50;code="73";
	picture p74;delta_time= 50;duration = 50;code="74";	picture p75;delta_time= 50;duration = 50;code="75";
	picture p76;delta_time= 50;duration = 50;code="76";	picture p77;delta_time= 50;duration = 50;code="77";
	picture p78;delta_time= 50;duration = 50;code="8";	   picture p79;delta_time= 50;duration = 50;code="79";
	picture p80;delta_time= 50;duration = 50;code="80";   picture p81;delta_time= 50;duration = 50;code="81";
	picture p82;delta_time= 50;duration = 50;code="82";	picture p83;delta_time= 50;duration = 50;code="83";
	picture p84;delta_time= 50;duration = 50;code="84";	picture p85;delta_time= 50;duration = 50;code="85";
	picture p86;delta_time= 50;duration = 50;code="86";	picture p87;delta_time= 50;duration = 50;code="87";
	picture p88;delta_time= 50;duration = 50;code="88";	picture p89;delta_time= 50;duration = 50;code="89";
	picture p90;delta_time= 50;duration = 50;code="90";
	
} MDtrial;

trial{ # feedback trial
	trial_duration = stimuli_length;
	trial_type = fixed;
	
	stimulus_event{
		picture empty_pic;
		time=0;
		duration = 200;
		code="PreFB";
		response_active=false;
		port_code=90;
	}pre_fb;

	stimulus_event {
		picture feedback_pic;								
		time = 200;
		duration = 1000;
		code="Feedback";
		response_active=false;
		port_code=100;
	} fb_e;
}fbtrial;

#####################################
#				BEGIN PCL					#
#####################################
		
begin_pcl;

double Coherence = 20; # default values
int condition = 1;	  # default values
input_file input = new input_file;
string input_name = "logfiles/coherence_condition.txt";

if input.open(input_name,false) == true then		# read in coherence and condition from input file, if it exists
	input.set_delimiter(32); 							# space as delimiter
	Coherence= double(input.get_line());
	condition = int(input.get_line()); 
end;

#####################################
#				VARIABLES DEFINED			#
#####################################

int 				j;													# just a counter
int 				frame_total=90;
int				result_button;
int				cbreak = 1; #UB03dec2011, control if break is possible

int 				k;
int 				p;
int 				trial_counter;
int				block;
int				trialno;
int 				correct_trials;
int 				miss_trials;
int 				cueValidity;
int				early_responses;
int				blank_duration;
int				cue_duration;
int				cue_stim;
double			xpos; 											# The x coordinate of a dot
double			ypos; 											# The y coordinate of a dot
double 			moving_length = 1.0;
							# the amount of pixels that a moving dot is replaced

include "settings.pcl";

int 				moving_size = int(round((Coherence*numdots/100),0)); # set number of moving dots according to coherence
int				eventOnset = 0;
int				dir;													# Motion direction (-1 left, 1  right
int 				target;												# target response button (1 left, 2 right)
array <double> position[frame_total][2][numdots]; 			# The array containing positions of the moving dots

# No. of responses until now
int 				last_resp_count;
int				last_stim_count;
int				MDK_onset;
int 				MDK_offset;
int				cue_onset;
int				blank_onset;
int				cur_resp;
int				result_time;
int				boxresp;
int				box_onset;

string			introText;

include "customLog.pcl";
addColumn( "block" );
addColumn( "trial" );
addColumn( "targetButton" );
addColumn( "correct" );
addColumn( "movement");
addColumn( "cue" );
addColumn( "cueValidity");
addColumn( "blankdur");
addColumn( "cuedur");
addColumn( "RT" );
addColumn( "blank_onset");
addColumn( "cue_onset");
addColumn( "MDK_onset");
addColumn( "MDK_offset");
addColumn( "Box_onset");
addColumn( "Box_response");
addColumn( "earlyResp");
addColumn( "feedbackTrial");
addColumn( "feedback");
addColumn( "coherence" );

initCustomLog();

##########################################################
# sequence of trials #
##########################################################

array <int> trial_id[0]; # contains the sequence of trials, 1: control, 2: left cue (red cross), 3: right cue (green cross)

array <int> block_control_trials[trial_control/n_blocks];
block_control_trials.fill(1,block_control_trials.count(), 1,0);
array <int> block_left_trials[trial_cued/n_blocks/2];
block_left_trials.fill(1,block_left_trials.count(), 2,0);
array <int> block_right_trials[trial_cued/n_blocks/2];
block_right_trials.fill(1,block_right_trials.count(), 3,0);

array <int> block_trials[0]; # put together control, left cue and right cue trials for one block
block_trials.append(block_control_trials);
block_trials.append(block_left_trials);
block_trials.append(block_right_trials);

loop int i = 1 until i>n_blocks # randomize trials in each block
begin
	block_trials.shuffle();
	trial_id.append(block_trials);
	i = i+1;
end;

############################################### show it! ############################################################

block=1;    # initialise block and trial counters at 1
trialno=1;
correct_trials = 0;
miss_trials = 0;
#output_port port = output_port_manager.get_port(1); # enable when output port present

loop trial_counter=1 until trial_counter > trial_total # go through all trials
begin	
	
	if trialno == 1 then # show cue directions at beginning of each block
	
			if condition == 1 then
				dir_boxes_1.present();
			else
				dir_boxes_2.present();
			end;
			box_onset = stimulus_manager.last_stimulus_data().time();
			setColumn("Box_onset",string(box_onset));
			boxresp = response_manager.last_response_data().time();
			setColumn("Box_response", string(boxresp));
	end;

	# break trial at the end of each block but not the final trial of the experiment
	if (trial_counter - 1) % trial_per_block == 0 && cbreak == 1 && trial_counter != 1 && trial_counter != trial_total then
		response_manager.set_button_active(1,false);
		response_manager.set_button_active(2,false);
		info1.set_caption(tbreak);
		info1.redraw();
		info1_trial.present();
		cbreak = 0;
		block = block + 1;    # update counter for block number
		trialno = 1;
		response_manager.set_button_active(1,true);
		response_manager.set_button_active(2,true);
		# reset trial number to 1 for each new block
		
	else # trial without break
		cbreak = 1;
		
		# Dots to the left or to the right?
		if trial_id[trial_counter] == 1 then # control trial - white cross
			cue.set_port_code(20);
			if random() <= 0.5 then  # random direction
				dir = -1;
				target=1;
				first_md_e.set_port_code(50);
			else 
				dir = 1;
				target=2;
				first_md_e.set_port_code(60);
			end;
				cueValidity = 0;
		elseif trial_id[trial_counter] == 2 then # left trial - red cross
			cue.set_port_code(30);
			if random() <= validity then
				dir = -1; # valid cue - does move to the left
				target=1;
				first_md_e.set_port_code(50);
			else 
				dir = 1;
				target=2;
				first_md_e.set_port_code(60);
			end;
			cueValidity = -dir;
		elseif trial_id[trial_counter] == 3 then # right trial - green cross
			cue.set_port_code(40);
			if random() <= validity then
				dir = 1; # valid cue - does move to the right
				target=2;
				first_md_e.set_port_code(60);
			else 
				dir = -1;
				target=1;
				first_md_e.set_port_code(50);
			end;
			cueValidity = dir;
		end;
		
		first_md_e.set_target_button(target);
		
		# jitter intervals
		blank_duration = random(blank_dur[1], blank_dur[2]);
		cue_duration = random(cue_dur[1],cue_dur[2]);
		
		# set durations
		blank.set_duration(blank_duration);
		cue.set_duration(cue_duration);
		MDtrial.set_duration(move_duration);
		pre_fb.set_duration(pre_fb_duration);
		fb_e.set_duration(fb_duration);

		setColumn("blankdur", string(blank_duration));
		setColumn("cuedur", string(cue_duration));
		setColumn("cue", string(cueValidity*dir));       
		setColumn("cueValidity", string(cueValidity));
		setColumn("block", string(block) );		
		setColumn("trial", string(trialno) );	
		setColumn("movement", string(dir) );			
		setColumn("targetButton", string(target));
		setColumn("coherence", string(Coherence));			
		
		# make moving dot frames
		k=1;
		loop j=1 until j > numdots 							# first frame
		begin;
			xpos=(random()*2.50-1.25)*100.0;
			ypos=(random()*2.50-1.25)*100.0;
			if dist(0.0,0.0,xpos,ypos)<125.0 then;
				position[k][1][j]=xpos; 
				position[k][2][j]=ypos; 
				j=j+1;
			end;
		end;
			
		loop k=2 until k>frame_total
		 begin;			
			loop j=1 until j > numdots-moving_size			# filling the stay array with random dot positions
			 begin;
				xpos=(random()*2.50-1.25)*100.0;
				ypos=(random()*2.50-1.25)*100.0;
				if dist(0.0,0.0,xpos,ypos)<125.0 then;
					position[k][1][j]=xpos;
					position[k][2][j]=ypos;
					j=j+1;
				end;
			 end;
			
	# filling loop 
			loop j=1 until j > moving_size 					# filling the moving array with dots some pixels to the right or left
			 begin;
				position[k][1][j+numdots-moving_size]=position[k-1][1][j]+double(dir)*moving_length;
				position[k][2][j+numdots-moving_size]=position[k-1][2][j];
				j = j+1;
			 end;
			k=k+1;
		end;

		loop j=1 until j > numdots
		begin;
			loop int pic=1 until pic>movdot_pics.count() begin
				movdot_pics[pic].add_part(dot,position[pic][1][j],position[pic][2][j]);
				pic=pic+1;
			end;
			j=j+1;
		end;
		
		loop int pic=1 until pic>movdot_pics.count() 
		begin
				
			if trial_id[trial_counter] == 1 then # control trial - white cross
				movdot_pics[pic].add_part(fix_horiz_w,0,0);
				movdot_pics[pic].add_part(fix_vert_w,0,0);
			elseif trial_id[trial_counter] == 2 then # left trial 
				if condition == 1 then # condition 1 : left - red
					movdot_pics[pic].add_part(fix_horiz_r,0,0);
					movdot_pics[pic].add_part(fix_vert_r,0,0);
				else  						# condition 2: left - green
					movdot_pics[pic].add_part(fix_horiz_g,0,0);
					movdot_pics[pic].add_part(fix_vert_g,0,0);
				end;
			elseif trial_id[trial_counter] == 3 then # right trial
				if condition == 1 then						# condition 1: right - green
					movdot_pics[pic].add_part(fix_horiz_g,0,0);
					movdot_pics[pic].add_part(fix_vert_g,0,0);
				else 												# condition 2: right - red
					movdot_pics[pic].add_part(fix_horiz_r,0,0);
					movdot_pics[pic].add_part(fix_vert_r,0,0);
				end;
			end;
			pic=pic+1;
		end;
	
		## Store the state of the response manager before presenting the trial
		last_resp_count = response_manager.response_data_count();
		
		## present trials and store onset times
		blank_trial.present(); # present blank trial
		blank_onset = stimulus_manager.last_stimulus_data().time();
		
		cuetrial.present(); # present cue
		cue_stim = stimulus_manager.stimulus_count();
		cue_onset = stimulus_manager.last_stimulus_data().time();
		
		early_responses = response_manager.response_data_count()-last_resp_count; # check for too early responses
		
		MDtrial.present();# present moving dots
		MDK_onset = stimulus_manager.get_stimulus_data(cue_stim+1).time(); # necessary to use counter cue_stim, because MD contains many stimuli 
		MDK_offset = clock.time();														 # and we want to get the timing of the first one
		
		stimulus_data curStimulus;
		response_data resp;

		if (last_resp_count+early_responses < response_manager.response_data_count()) then 		# Check if the participant responded after MD onset
			# Get the first response made after the presentation of the previous trial:
			resp = response_manager.get_response_data(last_resp_count+early_responses+1);
			result_time = resp.time()-MDK_onset;
			result_button = resp.button();
			term.print("Found new responses! " + string(response_manager.response_data_count()) + " " + string(last_resp_count) + ": " + string(result_time) + " " + string(result_button) + " "+ string (target) + "\n");
				
			# response correct?
			if result_button == target then
				correct_trials = correct_trials +1; 
				setColumn("correct", "1" );
			else	
				setColumn("correct", "-1" );
			end;

			setColumn("RT", string(result_time));
			
		else 			# no response - assign filler values 
			result_time = -1;
			result_button = -1;
			miss_trials = miss_trials+1;
			setColumn("resp", string(result_button));
			setColumn("RT", string(result_time));
			setColumn("correct", "0" );
		end;

		## Clear the moving dot frames
		loop int pic=1 until pic>movdot_pics.count() 
		begin
			movdot_pics[pic].clear();
			pic=pic+1;
		end;
		
		setColumn("MDK_offset", string(MDK_offset));
		
		if trialno%no_fbtrials == 0 then # show feedback on every no_fbtrial-th trial 
			feedback.set_caption(string(correct_trials*100/no_fbtrials) + "% correct!");
			if miss_trials > 1 then
				feedback.set_caption(string(correct_trials*100/no_fbtrials) + "% correct!\n\n"+
											"Please respond faster!");
			end;
			
			feedback.redraw();
			fbtrial.present();
			setColumn("feedbackTrial", "1");
			setColumn("feedback",string(correct_trials));
			setColumn("trialTime", string(blank_duration+cue_duration+MDK_offset - MDK_onset));
			correct_trials = 0;
			miss_trials = 0;
			
			if condition == 1 then # present arrow boxes again
				dir_boxes_1.present();
			else 
				dir_boxes_1.present();
			end;
 
			box_onset = stimulus_manager.last_stimulus_data().time();
			setColumn("Box_onset",string(box_onset));
			boxresp = response_manager.last_response_data().time();
			setColumn("Box_response", string(boxresp));
			
			
		else		# filler values for trials without feedback		
			setColumn("feedbackTrial","0");
			setColumn("feedback", "NA");
			if trialno != 1 then
				setColumn("Box_onset","NA");
				setColumn("Box_response", "NA");
			end; 
		end; 
		
		setColumn("earlyResp", string(early_responses));
		setColumn("blank_onset", string(blank_onset));
		setColumn("cue_onset", string(cue_onset));
		setColumn("MDK_onset", string(MDK_onset));
		trial_counter=trial_counter+1;  # update trial_counter for iteration through arrays
		trialno=trialno+1;  				  # update trialno for trial position within each block, for data file			
		writeLine();
			
	end;
end;

info1.set_caption("END");
info1.redraw();
info1_trial.present();