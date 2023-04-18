#include <Hana.h>

class ExampleLayer : public Hana::Layer
{
public:
	ExampleLayer()
		: Layer("Example")
	{
	}

	void OnUpdate() override
	{
		if (Hana::Input::IsKeyPressed(HN_KEY_TAB))
			HN_TRACE("Tab key is pressed (poll)!");
	}

	void OnEvent(Hana::Event& event) override
	{
		if (event.GetEventType() == Hana::EventType::KeyPressed)
		{
			Hana::KeyPressedEvent& e = (Hana::KeyPressedEvent&)event;
			if (e.GetKeyCode() == HN_KEY_TAB)
				HN_TRACE("Tab key is pressed (event)!");
			HN_TRACE("{0}", (char)e.GetKeyCode());
		}
	}
};

class Sandbox : public Hana::Application
{
public:
	Sandbox()
	{
		PushLayer(new ExampleLayer());
		PushOverlay(new Hana::ImGuiLayer());
	}

	~Sandbox()
	{

	}
};

Hana::Application* Hana::CreateApplication()
{
	return new Sandbox();
}
