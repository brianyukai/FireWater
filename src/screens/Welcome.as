package screens
{
	import com.greensock.TweenLite;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.core.Starling;
	
	import events.NavigationEvent
	
	/**
	 * ...
	 * @author Pablo Granada
	 */
	
	public class Welcome extends Sprite
	{
		private var aboutWinw:Button;
		private var arcademenu:Button;
		private var storymenu:Button;
		
		
		public function Welcome() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
		}
		
		private function onAddedToStage(event:Event):void
		{
			trace("welcome screen initialized");
			drawScreen();				
		}
		
		
		
		
		
		private function drawScreen():void 
		{
			
			
			arcademenu = new Button(Assets.getTexture("WelcomeArcademenu"));
			arcademenu.x = 800;
			arcademenu.y = 50;
			this.addChild(arcademenu);
			
			storymenu = new Button(Assets.getTexture("WelcomeStorymenu"));
			storymenu.x = 800;
			storymenu.y = 200;
			this.addChild(storymenu);
			
			aboutWinw = new Button(Assets.getTexture("WelcomeAboutWinw"));
			aboutWinw.x = 800;
			aboutWinw.y = 350;
			this.addChild(aboutWinw);
			
			this.addEventListener(Event.TRIGGERED, onMainMenuClick);
			
		}
		
		private function onMainMenuClick(event:Event):void 
		{	
			var buttonClicked:Button = event.target as Button;
			if ((buttonClicked as Button) == storymenu)
			{
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, { id: "play" }, true));
			}
			
		}
		
				
		public function initialize():void
		{
			this.visible = true;
			
			
		}
		
		public function disposeTemporarily():void
		{
			this.visible = false;
			
			
		}
		
				
		
		
	}

}