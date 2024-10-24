package ar.reports;

import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.lippia.api.lowcode.steps.StepsInCommon;

import java.io.UnsupportedEncodingException;

public class ProjectSteps extends StepsInCommon {
    @And("^define valor aleatorio (.*)$")
    public void generateRandomProjectName(String key) throws UnsupportedEncodingException {
        String valorAleatorio = key+"_" + (int) (Math.random() * 10000);
        setVariable(key, valorAleatorio);
    }
}
