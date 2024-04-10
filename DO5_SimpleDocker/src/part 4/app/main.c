#include <fcgiapp.h>
#include <stdio.h>

int main() {
    FCGX_Init();
    int Socket = FCGX_OpenSocket("127.0.0.1:8080", 1024);
    FCGX_Request Request;
    FCGX_InitRequest(&Request, Socket, 0);

    while (FCGX_Accept_r(&Request) >= 0) {
        FCGX_FPrintF(Request.out,
            "Content-type: type/html\r\n\r\nHello, world!\r\n");
        FCGX_Finish_r(&Request);
    }
    return 0;
}
