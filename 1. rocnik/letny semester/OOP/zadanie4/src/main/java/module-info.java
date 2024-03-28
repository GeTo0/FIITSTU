module com.example.zadanie4 {
    requires javafx.controls;
    requires javafx.fxml;

    requires org.controlsfx.controls;
    requires org.kordamp.bootstrapfx.core;
    requires com.almasb.fxgl.all;

    opens com.example.zadanie4 to javafx.fxml;
    exports com.example.zadanie4;
}