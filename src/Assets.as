package  
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	/**
	 * ...
	 * @author Pablo Granada
	 */
	public class Assets 
	{
		[Embed(source = "../media/graphics/chustavolcan.png")]
		public static const chustavolcan:Class;
		
		[Embed(source = "../media/graphics/descarga.jpg")]
		public static const descarga:Class;
				
		[Embed(source = "../media/graphics/images.png")]
		public static const images:Class;
		
		[Embed(source = "../media/graphics/tenis.png")]
		public static const tenis:Class;
		
		[Embed(source = "../media/graphics/suelomangui.png")]
		public static const suelomangui:Class;
		
		[Embed(source = "../media/graphics/paredmangui.png")]
		public static const paredmangui:Class;
		
		[Embed(source = "../media/graphics/250px-Volleyball.png")]
		public static const voleyball:Class;
		
		[Embed(source="../media/graphics/About_window.png")]
		public static const WelcomeAboutWinw:Class;
		
		[Embed(source="../media/graphics/Arcade_menu.png")]
		public static const WelcomeArcademenu:Class;
		
		[Embed(source="../media/graphics/Story_menu.png")]
		public static const WelcomeStorymenu:Class;
		
		private static var gameTextures:Dictionary = new Dictionary ();
		
		public static function getTexture(name:String):Texture
		{
			if (gameTextures[name] == undefined)
			{
				var bitmap:Bitmap = new Assets[name]();
				gameTextures[name] = Texture.fromBitmap(bitmap);
			}   
			return gameTextures[name];
		}
		
	}

}