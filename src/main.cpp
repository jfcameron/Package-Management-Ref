#include <Hunter-Reference/DemoGLWindow.h>

#include <vector>

namespace
{
    auto shouldClose = false;

    constexpr size_t WINDOW_NUMBER = 10;
}

int main(void)
{
    std::vector<gfx::DemoGLWindow *> windows;

    for (size_t i = 0; i < WINDOW_NUMBER; ++i) windows.push_back(new gfx::DemoGLWindow());
    
    while (!shouldClose) for (const auto &window : windows) 
    {
        window->update();

        if ((shouldClose = window->shouldClose())) break;
    }
}
