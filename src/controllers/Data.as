package controllers
{
	import com.adobe.serialization.json.JSON;
	
	import flash.net.URLVariables;
	
	public class Data
	{
		
		private var _gameId:String = "test_game_id";  //przychodzi we falshcars
		protected var _userId:String;  //przychodzi jako id
		protected var _facebookId:String;  //facebook_id
		
		protected var _code:String = "3kg090mrne9";
		
		protected var _user_won:Boolean = false;
		private var _sendPost:SendPost =  new SendPost();
		public function Data()
		{
		}
		
		// FACEBOOK DATA
		public function sendGameId():void{
			var send_game_id:SendPost =  new SendPost();
			var data:URLVariables =  new URLVariables();
			data.id = _gameId;
			data.c = _code;
			send_game_id.sendPost(send_game_id.INFO,data,reciveFacebookData);
		}
		private function reciveFacebookData(e:Object):void
		{
			var obj:Object = JSON.decode(e.target.data)
			//			_first_name = obj.first_name;
			//			_last_name =  obj.last_name;
			//			_userId = obj.id;
			//			_facebookId  = obj.facebook_id;
		}
		//ASK IF WIN
		public function sendWin():void{
			var send_win:SendPost =  new SendPost();
			var data:URLVariables = new URLVariables();
			data.c = _code;
			data.gameId = _gameId;
			data.userId  = _userId;
			send_win.sendPost(send_win.WIN,data,reciveWin,true)
		}
		private function reciveWin(e:Object):void{
			var obj:Object = JSON.decode(e.target.data)
			
			_user_won = obj.user_won;
			//show aword

		}

		public function get gameId():String
		{
			return _gameId;
		}

		public function set gameId(value:String):void
		{
			_gameId = value;
		}

	}
}