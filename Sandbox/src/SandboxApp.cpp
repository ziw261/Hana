#include <Hana.h>

#include "imgui/imgui.h"

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

	virtual void OnImGuiRender() override
	{
		// This won't work because of linking problems.
		//ImGui::Begin("Test");
		//ImGui::Text("Hello World");
		//ImGui::End();
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
	}

	~Sandbox()
	{

	}
};

Hana::Application* Hana::CreateApplication()
{
	return new Sandbox();
}
