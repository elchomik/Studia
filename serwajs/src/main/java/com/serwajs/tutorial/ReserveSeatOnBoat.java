package com.serwajs.tutorial;

import org.camunda.bpm.engine.delegate.BpmnError;
import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;


public class ReserveSeatOnBoat implements JavaDelegate {

    @Override
    public void execute(DelegateExecution delegateExecution) throws Exception {
        String money = "0.0";
        String ticketType = "Coach";
        money = (String) delegateExecution.getVariable("money");
        delegateExecution.getVariableNames().forEach(System.out::println);
        double moneyDouble = Double.parseDouble(money);
        if (moneyDouble >= 10000) {
            ticketType = "First Class";
        } else if (moneyDouble >= 5000) {
            ticketType = "Second Class";
        } else if (moneyDouble <= 10) {
            ticketType = "Stowaway Class";
            throw new BpmnError("Fall_Overboard", "A cheap ticket has led to a small wave throwing you overboard.");
        }
        delegateExecution.setVariable("ticketType", ticketType);
    }
}
