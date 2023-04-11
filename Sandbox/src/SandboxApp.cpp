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
		HN_INFO("ExampleLayer::Update");
	}

	void OnEvent(Hana::Event& event) override
	{
		HN_TRACE("{0}", event);
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
