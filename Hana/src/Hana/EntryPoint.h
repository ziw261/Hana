#pragma once

#ifdef HN_PLATFORM_WINDOWS

extern Hana::Application* Hana::CreateApplication();

int main(int argc, char** argv)
{
	auto app = Hana::CreateApplication();
	app->Run();
	delete app;
}

#endif