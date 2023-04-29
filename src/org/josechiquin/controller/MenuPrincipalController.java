package org.josechiquin.controller;

import java.net.URL;
import java.util.ResourceBundle;
import javafx.fxml.Initializable;
import org.josechiquin.system.Principal;

public class MenuPrincipalController implements Initializable{    
    private Principal escenarioPrincipal;
    
    @Override
    public void initialize(URL location, ResourceBundle resources) {
        
    }

    public Principal getEscenarioPrincipal() {
        return escenarioPrincipal;
    }

    public void setEscenarioPrincipal(Principal escenarioPrincipal) {
        this.escenarioPrincipal = escenarioPrincipal;
    }
    public void ventanaProgramador(){
        escenarioPrincipal.ventanaProgramador();
    }
    public void ventanaPaciente(){
        escenarioPrincipal.ventanaPaciente();
    }    
    
    public void ventanaEspecialidades(){
        escenarioPrincipal.ventanaEspecialidades();
    }
    
    public void ventanaDoctores(){
        escenarioPrincipal.ventanaDoctores();
    }
    
    public void ventanaMedicamentos(){
        escenarioPrincipal.ventanaMedicamentos();
    }
}
