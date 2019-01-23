
active_buttons 	= 4;
button_codes = 1,2,3,4;
response_matching = simple_matching;

begin;

# fixation cross
box { height = 3; width = 50; color = 181,181,180; } fix_horiz_w;
box { height = 50; width = 3; color = 181,181,180; } fix_vert_w;

box { height = 3; width = 50; color = 255,100,255; } fix_horiz_r;
box { height = 50; width = 3; color = 255,100,255; } fix_vert_r;

box { height = 3; width = 50; color = 0,236,0; } fix_horiz_g;
box { height = 50; width = 3; color = 0,236,0; } fix_vert_g;

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
		

begin_pcl;

array<string>instructions[6];
instructions[1] = "Welcome to the experiment! \n \n This is a study about motion detection.\n\n"+
						"(Press one of the buttons to continue.)";
						
instructions[2] = "Before starting the actual experiment, we will conduct a\n"+
						"test session with a simplified version of the experimental task.\n\n"+
						"The test session lasts for around 10 minutes.";
						 
				
instructions[3] = "In each trial, you will be presented with a cloud of randomly moving dots.\n\n"+
						"Some of the dots move coherently to the left or right side. \n\n"+
						"Your task is to indicate if the dots are moving to the left or right \n" + 
						"by pressing the left or right response button.";
						
instructions[4] = "Try to respond as quickly and as accurately as possible.\n\n"+
						"Only respond, after the dots have started moving.";
						
instructions[5] = "Throughout the trial, a cross will be presented in the middle of the screen. \n\n" +
						"It is important that you fixate the cross.";
			
instructions[6] = "Ready? Let's go!";

loop int i = 1  until i > instructions.count()
begin;
	sli1.set_caption(instructions[i]);
	sli1.redraw();
	inst1.present();
	i = i+1;
end;
