@isTest
private class TestHelloWorld {
	@isTest static void hello() {
		HelloWorld hello_world = new HelloWorld();  
		String result = hello_world.hello();
	}
}