#include "Application.h"

#include "Hana/Events/ApplicationEvent.h"
#include "Hana/Log.h"

namespace Hana
{
	Application::Application()
	{

	}

	Application::~Application()
	{

	}

	void Application::Run()
	{
		WindowResizeEvent e(1280, 720);
		if (e.IsInCategory(EventCategoryApplication))
		{ 
			HN_TRACE(e);
		}
		if (e.IsInCategory(EventCategoryInput))
		{
			HN_TRACE(e);
		}

		while(true);
	}
}
