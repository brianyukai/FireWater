package screens
{
	import flash.ui.Keyboard;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.display.Image;
	import starling.events.KeyboardEvent;
	import com.reyco1.physinjector.data.PhysicsObject;
	import com.reyco1.physinjector.data.PhysicsProperties;
	import com.reyco1.physinjector.PhysInjector;
	import starling.core.Starling;
	import Box2D.Common.Math.b2Vec2;
	
	
	/**
	 * ...
	 * @author Laura
	 */
	
	public class InGame extends Sprite
	{
		
		private var floor:Image;
		private var keko:Image;
		private var bala:Image;
		private var paredizq:Image;
		private var paredder:Image;
		private var chustafondo:Image;
		private var basketBall:Image;
		private var tennisBall:Image;
        private var physics:PhysInjector;
		private var bg:Image;
		private var voleyball:Image;
		private var movingDown:Boolean = true;
		private var disparado:Boolean = false;
		
		private var proyectiles:Vector.<Image>;
		
		public function InGame() 
		{
			super();
			PhysInjector.STARLING = true;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			
		}
		
		private function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
						
			createSprites();
            injectPhysics();
			
			proyectiles = new Vector.<Image>();
			
			addEventListener(Event.ENTER_FRAME, onUpdate);
			trace("InGame screen initialized");
			
			
		}
		
		private function onUpdate(event:Event):void 
		{
			physics.update();
			stage.addEventListener(KeyboardEvent.KEY_DOWN, _handleKeyDown);
			if (keko.x > paredder.x - keko.width) 
			{
				keko.x = paredder.x- keko.width;
			}
			
			//Añado esta linea para probar el Git
			
			else if (keko.x - paredizq.width < paredizq.x) 
			{
				keko.x = paredizq.x + paredizq.width;
			}
			
			/*
			if (disparado == false) 
			{
				bala.x = keko.x + keko.width/2;
				bala.y = keko.y;
				
			}
			
			else 
			{
				bala.y -= 3;
			}
			
			*/
			
			//Este es el bucle que mueve todas las balas del vector que las contiene			
			for (var i:uint = 0; i < proyectiles.length; i++)
			{
				proyectiles[i].y -= 3;
			}
			
			/*
			if (bala.y < 0) 
			{
				bala.visible = false; //Aqui quiero destruirlo cuando salga de la pantalla, pero no sé como
			}
			
			*/
			
			
		}
		
		private function _handleKeyDown(event:KeyboardEvent):void 
		{
			/*if(event.keyCode == Keyboard.DOWN)
				movingDown = true;*/
				
			if(event.keyCode == Keyboard.A && movingDown)
				keko.x += -10;
			else if(event.keyCode == Keyboard.D && movingDown)
				keko.x += 10;
			else if (event.keyCode == Keyboard.G) 
			{
				//He movido aquí el spawner porque me daba problemas con el booleana. Trabajaremos en ello.
				bala = new Image(Assets.getTexture("bala"));
				bala.width = bala.width / 10;
				bala.height = bala.height / 10;
				bala.x = keko.x + keko.width/2;
				bala.y = keko.y;
				this.addChild(bala);
				
				proyectiles.push(bala);
				
			}
			
		}
		
		private function _handleKeyUp(event:KeyboardEvent):void 
		{
			 if(event.keyCode == Keyboard.G)
				disparado = false;
		}
		
		private function injectPhysics():void 
		{
						
			physics = new PhysInjector(Starling.current.nativeStage, new b2Vec2(0, 60), true);
			
            var floorObject:PhysicsObject = physics.injectPhysics(floor, 
				PhysInjector.SQUARE,
				new PhysicsProperties( {
				isDynamic:false, friction:0.5, restitution:0.5 } ));
				
        
			var paredderecha:PhysicsObject = physics.injectPhysics(paredizq,
				PhysInjector.SQUARE,
				new PhysicsProperties ( {
				isDynamic:false, friction: 0.5, restitution:0.5  } )); 
				//Faramir He estado probando otras propiedades fisicas como: linearVelocity:(1,2)
				//se supone que asi es como se marca el vector de fuerzas de salida de un objeto,
				//pero no chusca, cuando puedas echale un ojo.
			
			var paredizquierda:PhysicsObject = physics.injectPhysics(paredder,
				PhysInjector.SQUARE,
				new PhysicsProperties ( {
				isDynamic:false, friction: 0.5, restitution:0.5 } ));
				
			var keko_physics:PhysicsObject = physics.injectPhysics(keko,
				PhysInjector.SQUARE,
				new PhysicsProperties ( {
				isDynamic:false, friction: 0.5, restitution:0.1 } ));
				
				/*
				var voleyball:PhysicsObject = physics.injectPhysics(voleyball,
				PhysInjector.CIRCLE,
				new PhysicsProperties ( {
				isDinamic:true,isDraggable:false, friction: 0.2, restitution:0.9 } ));
				*/
			/*	
			
				
			 var tennisball:PhysicsObject = 
				physics.injectPhysics(tennisBall, 
				PhysInjector.CIRCLE, new PhysicsProperties
				( { isDynamic:true, friction:0.2, restitution:0.9 } ));
			
			var basketball:PhysicsObject = 
				physics.injectPhysics(basketBall, 
				PhysInjector.CIRCLE, new PhysicsProperties
				( { isDynamic:true, friction:0.2, restitution:0.9 } ));
				*/
				
				
		}
		
		private function createSprites():void 
		{
			chustafondo = new Image(Assets.getTexture("chustavolcan"));
			this.addChild(chustafondo);
			
						
			paredder = new Image (Assets.getTexture("paredmangui"));
			
			paredder.x = stage.stageWidth * 7 / 8;// 896;// stage.stageWidth;
            paredder.y = 0;// stage.stageHeight -100;
            this.addChild(paredder);
			
						
			paredizq = new Image (Assets.getTexture("paredmangui"));
			
			paredizq.x = stage.stageWidth / 8; //128;
            paredizq.y = 0; //stage.stageHeight - 100;
            this.addChild(paredizq);
			
			floor = new Image(Assets.getTexture("suelomangui"));
			
			
            floor.x = stage.stageWidth * 0.5 - floor.width * 0.5;
            floor.y = stage.stageHeight - floor.height - 50;
            this.addChild(floor);
			
			/*
            voleyball = new Image(Assets.getTexture("voleyball"));
			voleyball.x = stage.stageWidth * 0.5 - voleyball.width * 0.45;
			voleyball.y = 200;
			this.addChild(voleyball);
			*/
			
            /*basketBall = new Image(Assets.getTexture("images"));
            
            basketBall.x = stage.stageWidth * 0.5 - basketBall.width * 0.6;
            basketBall.y = 10;
            this.addChild(basketBall);
			
			
			
			
			
			tennisBall = new Image(Assets.getTexture("tenis"));
            
            tennisBall.x = stage.stageWidth * 0.5 - tennisBall.width * 0.45;
            tennisBall.y = 300;
            this.addChild(tennisBall);*/
			
			keko = new Image (Assets.getTexture("descarga"));
			
			keko.x = stage.stageWidth * 0.5 - keko.width * 0.45;
            keko.y = 450;
			this.addChild(keko);
			
			/*
			bala = new Image(Assets.getTexture("bala"));
			bala.width = bala.width / 10;
			bala.height = bala.height / 10;
			bala.x = keko.x + keko.width/2;
			bala.y = keko.y;
			this.addChild(bala);
			*/
			
			
			
			
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

