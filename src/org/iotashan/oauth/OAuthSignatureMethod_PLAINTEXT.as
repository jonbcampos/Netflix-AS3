package org.iotashan.oauth
{
	import org.iotashan.utils.URLEncoding;
	
	public class OAuthSignatureMethod_PLAINTEXT implements IOAuthSignatureMethod
	{
		public function OAuthSignatureMethod_PLAINTEXT()
		{
		}
		
		public function get name():String {
			return "PLAINTEXT";
		}
		
		public function signRequest(request:OAuthRequest):String {
			var sSec:String = request.consumer.secret + "&"
			if (request.token)
				sSec += request.token.secret;
				
			return sSec;
		}
	}
}