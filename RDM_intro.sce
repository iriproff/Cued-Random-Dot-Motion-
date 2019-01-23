
active_buttons 	= 4;
button_codes = 1,2,3,4;
response_matching = simple_matching;

begin;

# fixation cross
box { height = 3; width = 50; color = 181,181,180; } fix_horiz_w;
box { height = 50; width = 3; color = 181,181,180; } fix_vert_w;

box { height = 3; width = 50; color = 255,100,255; } fix_horiz_r;
box { height = 50; width = 3; color = 255,100,255; } fix_vert_r;

box { height = 3; width = 50; color = 0,245,0; } fix_horiz_g;
box { height = 50; width = 3; color = 0,245,0; } fix_vert_g;

arrow_graphic {
   coordinates = 40, 0, -40, 0;
   line_width = 5;
   head_width =   20;
   head_length =  20;
}arrow_left;

arrow_graphic {
   coordinates = -40, 0, 40, 0;
   line_width = 5;
   head_width =    20;
   head_length =   20;
}arrow_right;

picture {
	arrow_graphic arrow_left; x = -100; y = 150;
	arrow_graphic arrow_right; x = 100; y = 0;
	arrow_graphic arrow_left; x = -100; y = -150;
	arrow_graphic arrow_right; x = 100; y = -150;
#	box red_box; x = -100; y=0;
#	box green_box; x = 100; y=0;
	box fix_horiz_r; x=0; y=150;
	box fix_vert_r;  x=0; y=150;
	box fix_horiz_g; x=0; y=0;
	box fix_vert_g;  x=0; y=0;
	box fix_horiz_w; x=0; y=-150;
	box fix_vert_w;  x=0; y=-150;
} slide3_c1;

picture {
	arrow_graphic arrow_left; x = -100; y = 150;
	arrow_graphic arrow_right; x = 100; y = 0;
	arrow_graphic arrow_left; x = -100; y = -150;
	arrow_graphic arrow_right; x = 100; y = -150;
#	box red_box; x = -100; y=0;
#	box green_box; x = 100; y=0;
	box fix_horiz_g; x=0; y=150;
	box fix_vert_g;  x=0; y=150;
	box fix_horiz_r; x=0; y=0;
	box fix_vert_r;  x=0; y=0;
	box fix_horiz_w; x=0; y=-150;
	box fix_vert_w;  x=0; y=-150;
} slide3_c2;


trial{   
	trial_type=first_response;
	trial_duration=forever;
	picture{
		text{
			caption=" blub";font_size=30;
		} sli1;
		x=0;y=0;
	}slide1;
	code="instruction1";	
}inst1;
		

trial{   
	trial_type=first_response;
	trial_duration=forever;
	picture{
		text{
			caption="";font_size=30;
		} sli2_c1;
		x=0;y=0;
		box fix_horiz_r; x=500; y=90;
		box fix_vert_r; x=500; y=90;
		box fix_horiz_g; x=500; y=-50;
		box fix_vert_g; x=500; y=-50;
		box fix_horiz_w; x=500; y=-190;
		box fix_vert_w; x=500; y=-190;
	}slide2_c1;
	code="instruction2";	
}inst2_c1;

trial{   
	trial_type=first_response;
	trial_duration=forever;
	picture{
		text{
			caption="";font_size=30;
		} sli2_c2;
		x=0;y=0;
		box fix_horiz_g; x=500; y=90;
		box fix_vert_g; x=500; y=90;
		box fix_horiz_r; x=500; y=-50;
		box fix_vert_r; x=500; y=-50;
		box fix_horiz_w; x=500; y=-190;
		box fix_vert_w; x=500; y=-190;
	}slide2_c2;
	code="instruction2";	
}inst2_c2;

trial{   
	trial_type=first_response;
	trial_duration=forever;
	picture slide3_c1;
	code="instruction3";	
}inst3_c1;

trial{   
	trial_type=first_response;
	trial_duration=forever;
	picture slide3_c2;
	code="instruction3";	
}inst3_c2;

begin_pcl; 

# get palmer coherence level and condition from user
preset double Coherence = 50;
preset int condition = 1;
# store these values in a text file to use them in the training and experiment
output_file ofile = new output_file;
ofile.open("coherence_condition.txt",true);
ofile.print(string(Coherence)+" "+string(condition));
ofile.close();

array<string>instructions[12];
instructions[1] = "Welcome to the experiment! \n \n This is a study about motion detection. \n\n" +
						"(Press one of the buttons to continue.)"; 
						
instructions[2] = "There will be 4 blocks which last for around 12 minutes each. \n\n" +
						"Between the blocks you'll have the opportunity to take a short break.";
										
instructions[3] = "In each trial, you will be presented with a cloud of randomly moving dots. \n\n"+
						"Some of the dots move coherently to the left or right side. \n\n"+
						"Your task is to indicate if the dots are moving to the left or right \n" + 
						"by pressing the left or right response button.";
						
instructions[4] = "Try to respond as fast as possible without making mistakes.\n\n"+
						"Only respond, after the dots have started moving. \n\n"+
						"Always respond, before the dots disappear.";
instructions[5] = "Throughout the trial, a cross will be presented in the middle of the screen.\n \n" +
						"It is important that you fixate the cross, \n" +
						"because eye movements disturb the signal we measure with EEG. \n \n"+
						"Please try to blink when the black screen is displayed between trials,\n"+
						"rather than during trials.";	
instructions[6] = "Sometimes, you will receive feedback about your performance.\n\n\n"+
						"This might look like this:";

instructions[7] = "73% correct! \n\n Please respond faster!";
						
						
instructions[8] = "In some trials, you will receive a cue before the dots start moving. \n\n"+
						"If the fixation cross is red, there is a higher probability \n"+
						"that the dots move to the left in the upcoming trial. \n\n" +
						"If the fixation cross is green, there is a higher probability \n" +
						"that the dots move to the right in the upcoming trial.\n\n"+
						"If the fixation cross is grey, the probability that the dots \n" +
						"move to the right or left is equal in the upcoming trial.";
						
instructions[9] = "In some trials, you will receive a cue before the dots start moving. \n\n"+
						"If the fixation cross is green, there is a higher probability \n"+
						"that the dots move to the left in the upcoming trial. \n\n" +
						"If the fixation cross is red, there is a higher probability \n" +
						"that the dots move to the right in the upcoming trial.\n\n"+
						"If the fixation cross is grey, the probability that the dots \n" +
						"move to the right or left is equal in the upcoming trial.";
				
instructions[10] = "The following screen will appear as reminder of the cues after each feedback. \n\n"+
						"When you see it, press any button to continue.";
						
instructions[11] = "Keep this information in mind. It can help you make your decision. \n \n"+
						"However, note that in the some trials the dots \n"+
						"move in the other direction than indicated by the cue.";

instructions[12] = " We will start with a training session of around 5 minutes.\n\n\n Ready? Let's go!";

loop int i = 1  until i > 7
begin;
	sli1.set_caption(instructions[i]);
	sli1.redraw();
	inst1.present();
	i = i+1;
end;

if condition ==1 then
	sli2_c1.set_caption(instructions[8]);
	sli2_c1.redraw();
	sli1.set_caption(instructions[10]);
	sli1.redraw();
	inst2_c1.present();
	inst1.present();
	inst3_c1.present();
else
	sli2_c2.set_caption(instructions[9]);
	sli2_c2.redraw();
	sli1.set_caption(instructions[10]);
	sli1.redraw();
	inst2_c2.present();
	inst1.present();
	inst3_c2.present();
end;

loop int i = 11  until i > instructions.count()
begin;
	sli1.set_caption(instructions[i]);
	sli1.redraw();
	inst1.present();
	i = i+1;
end;