#pragma once

#include "Core.h"

#include "Window.h"
#include "Hana/LayerStack.h"
#include "Hana/Events/Event.h"
#include "Hana/Events/ApplicationEvent.h"

#include "Hana/ImGui/ImGuiLayer.h"

#include "Hana/Renderer/Buffer.h"
#include "Hana/Renderer/Shader.h"
#include "Hana/Renderer/VertexArray.h"

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

		inline Window& GetWindow() { return *m_Window; }

		inline static Application& Get() { return *s_Instance; }
	private:
		bool OnWindowClose(WindowCloseEvent& e);

		std::unique_ptr<Window> m_Window;
		ImGuiLayer* m_ImGuiLayer;
		bool m_Running = true;
		LayerStack m_LayerStack;

		std::shared_ptr<Shader> m_Shader;
		std::shared_ptr<VertexArray> m_VertexArray;

		std::shared_ptr<Shader> m_BlueShader;
		std::shared_ptr<VertexArray> m_SquareVA;
	private:
		static Application* s_Instance;
	};

	// To be defined in the client
	Application* CreateApplication();
}
