package com.serwajs.tutorial;

import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/revolution")
class RevolutionController {

    private final CamundaFacade camundaFacade;

    RevolutionController(CamundaFacade camundaFacade) {
        this.camundaFacade = camundaFacade;
    }

    @PostMapping("/start/{key}")
    public String startRevolution(@PathVariable String key) {
        return camundaFacade.startProcessById(key);
    }

    @GetMapping("/isRunning/{processInstanceId}")
    public Boolean isProcessRunning(@PathVariable String processInstanceId) {
        return camundaFacade.isProcessInstanceIsRunning(processInstanceId);
    }
}
