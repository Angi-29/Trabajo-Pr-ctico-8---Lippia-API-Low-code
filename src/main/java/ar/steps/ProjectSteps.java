package ar.steps;

import io.cucumber.java.en.And;
import io.lippia.api.lowcode.steps.StepsInCommon;

import java.io.UnsupportedEncodingException;

public class ProjectSteps {
    private StepsInCommon stepsInCommon = new StepsInCommon();

    @And("^define valor aleatorio (.*)$")
    public void generateRandomProjectName(String key) throws UnsupportedEncodingException {
        String valorAleatorio = key + "_" + (int) (Math.random() * 10000);
        // Usa stepsInCommon en lugar de herencia
        stepsInCommon.setVariable(key, valorAleatorio);
    }

    @And("valores recuperados (\\S+),(\\S+)")
    public void valoresRecuperados(String arg0, String arg1) {
        System.out.println("Valor1: "+arg0+" Valor2:"+arg1);
    }
}
