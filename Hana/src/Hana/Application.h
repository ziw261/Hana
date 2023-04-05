#pragma once

#include "Core.h"

#include "Window.h"
#include "Hana/LayerStack.h"
#include "Hana/Events/Event.h"
#include "Hana/Events/ApplicationEvent.h"


namespace Hana
{
	class HANA_API Application
	{
	public:
		Application();
		virtual ~Application();
	
		void Run();

		void OnEvent(Event& e);

		void PushLayer(Layer* layer);
		void PushOverlay(Layer* layer);
	private:
		bool OnWindowClose(WindowCloseEvent& e);

		std::unique_ptr<Window> m_Window;
		bool m_Running = true;
		LayerStack m_LayerStack;
	};

	// To be defined in the client
	Application* CreateApplication();
}
