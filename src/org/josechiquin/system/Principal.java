/*
Nombre: Jose Daniel Chiquin Montenegro
Código Técnico: IN5AM
Carné: 2017515
Fecha de creación: 05/04/2022
Fechas de Modificaciones: 06/03/2022 -- 30/04/2022 -- 05/05/2022  -- 10/05/2022 -- 24/05/2022
 */
package org.josechiquin.system;

import java.io.IOException;
import java.io.InputStream;
import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.fxml.JavaFXBuilderFactory;
import javafx.scene.Parent;

import javafx.scene.Scene;
import javafx.scene.image.Image;
import javafx.scene.layout.AnchorPane;
import javafx.stage.Stage;
import org.josechiquin.controller.DoctorController;
import org.josechiquin.controller.EspecialidadController;
import org.josechiquin.controller.MedicamentoController;
import org.josechiquin.controller.MenuPrincipalController;
import org.josechiquin.controller.PacienteController;
import org.josechiquin.controller.ProgramadorController;

public class Principal extends Application {
    private final String PAQUETE_VISTA = "/org/josechiquin/view/";
    private Stage escenarioPrincipal;
    private Scene escena;
    
    @Override
    public void start(Stage escenarioPrincipal)throws Exception {
        this.escenarioPrincipal = escenarioPrincipal;
        this.escenarioPrincipal.setTitle("Blancolmillo 2022");
        escenarioPrincipal.getIcons().add(new Image("/org/josechiquin/image/FondoPrincipal2022.png"));
//        Parent root = FXMLLoader.load(getClass().getResource("/org/josechiquin/view/MenuPrincipalView.fxml"));
//        Scene escena = new Scene(root);
//        escenarioPrincipal.setScene(escena);
        menuPrincipal();
        escenarioPrincipal.show();
    }
    
    
    public void menuPrincipal(){
        try{
            MenuPrincipalController ventanaMenu = (MenuPrincipalController)cambiarEscena("MenuPrincipalView.fxml",390,410);
            ventanaMenu.setEscenarioPrincipal(this);
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public void ventanaProgramador(){
        try{
            ProgramadorController vistaProgramador = (ProgramadorController)cambiarEscena("ProgramadorView.fxml",600,400);
            vistaProgramador.setEscenarioPrincipal(this);           
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public void ventanaPaciente(){
        try{
            PacienteController vistaPaciente = (PacienteController)cambiarEscena("PacienteView.fxml",1070,400);
            vistaPaciente.setEscenarioPrincipal(this);
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public void ventanaEspecialidades(){
        try{
            EspecialidadController vistaEspecialidad = (EspecialidadController)cambiarEscena("EspecialidadesView.fxml",743,400);
            vistaEspecialidad.setEscenarioPrincipal(this);
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public void ventanaDoctores(){
        try{
            DoctorController vistaDoctor = (DoctorController)cambiarEscena("DoctoresView.fxml",957,400);
            vistaDoctor.setEscenarioPrincipal(this);
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public void ventanaMedicamentos(){
        try{
            MedicamentoController vistaMedicamento = (MedicamentoController)cambiarEscena("MedicamentosView.fxml",794,400);
            vistaMedicamento.setEscenarioPrincipal(this);
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public static void main(String[] args) {
        launch(args);
    }
        
    public Initializable cambiarEscena(String fxml, int ancho, int alto)throws Exception{
        Initializable resultado = null;
        FXMLLoader cargadorFXML = new FXMLLoader();
        InputStream archivo = Principal.class.getResourceAsStream(PAQUETE_VISTA+fxml);
        cargadorFXML.setBuilderFactory(new JavaFXBuilderFactory());
        cargadorFXML.setLocation(Principal.class.getResource(PAQUETE_VISTA+fxml));
        escena = new Scene((AnchorPane)cargadorFXML.load(archivo),ancho,alto);
        escenarioPrincipal.setScene(escena);
        escenarioPrincipal.sizeToScene();
        resultado = (Initializable)cargadorFXML.getController();
        return resultado;
    }
    
}