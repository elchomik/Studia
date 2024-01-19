package com.serwajs.tutorial;

import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/revolution")
class RevolutionController {

    private final CamundaFacade camundaFacade;

    RevolutionController(final CamundaFacade camundaFacade) {
        this.camundaFacade = camundaFacade;
    }

    @PostMapping("/start/{key}")
    public String startRevolution(@PathVariable final String key) {
        return camundaFacade.startProcessById(key);
    }

    @GetMapping("/isRunning/{processInstanceId}")
    public Boolean isProcessRunning(@PathVariable final String processInstanceId) {
        return camundaFacade.isProcessInstanceIsRunning(processInstanceId);
    }

    @PostMapping("/start/overthrowMonarchy")
    public String startProcessFromMonarchy(@RequestParam final String key) {
        return camundaFacade.startProcessBeforeOverthrowMonarchy(key);
    }

    @PostMapping("/start/taxi")
    public String startProcessFromTaxi(@RequestParam final String key) {
        return camundaFacade.startProcessBeforeTaxi(key);
    }

    @PostMapping("/start/departure")
    public String startProcessFromDeparture(@RequestParam final String key) {
        return camundaFacade.startProcessBeforeDeparture(key);
    }
}
