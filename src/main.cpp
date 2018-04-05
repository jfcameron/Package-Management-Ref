#include <Hunter-Reference/DemoGLWindow.h>

int main(void)
{
    gfx::DemoGLWindow window;

    while (!window.shouldClose()) window.update();
}
