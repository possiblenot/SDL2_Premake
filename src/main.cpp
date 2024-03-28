#define SDL_MAIN_HANDLED
#include "SDL/SDL.h"

#include <iostream>







int main()
{
	if (SDL_Init(SDL_INIT_VIDEO) < 0)
	{
		std::cout << "Failed to initialize SDL2\n";
		return -1;
	}
	SDL_Window* window = SDL_CreateWindow("Premake",
										  SDL_WINDOWPOS_CENTERED,
										  SDL_WINDOWPOS_CENTERED,
										  680,
										  480,
										  0);

	if (!window)
	{
		std::cout << "Failed to create window\n";
		return -1;
	}

	SDL_Renderer* renderer = nullptr;
	renderer = SDL_CreateRenderer(window, -1, 0);
	if (!renderer)
	{
		std::cout << "Failed to create renderer\n";
	}

	SDL_SetRenderDrawColor(renderer, 55, 100, 33, 255);

	bool keep_open = true;
	SDL_Event e;

	// main loop
	while (keep_open)
	{
		SDL_PollEvent(&e);
		SDL_RenderClear(renderer);
		switch (e.type)
		{
			case SDL_QUIT:
			{
				keep_open = false;
				break;
			}

			// Handle Keyboard
			case SDL_KEYDOWN:
			{
				if (e.key.keysym.sym == SDLK_ESCAPE)
				{
					keep_open = false;
				}
				break;
			}

			default:
				break;
		}
		SDL_RenderPresent(renderer);
	}
	SDL_Quit();
	return 0;
}


