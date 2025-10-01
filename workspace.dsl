workspace {

    model {

        # Actors
        admin = person "Administrador"
        client = person "Cliente Zero Stress"
        staff = person "Personal Operativo"

        # External Systems
        whatsapp = softwareSystem "WhatsApp" "Plataforma de mensajería (WhatsApp Business API)" "external"
        llm = softwareSystem "LLM" "Sistema de IA" "external"
        
        zeroStressSystem = softwareSystem "Zero Stress Pool Management System" {

        }

        # Relationships
        admin -> zeroStressSystem "Gestiona POS y consulta métricas de Piscina Zero Stress"
        admin -> whatsapp "Realiza consultas sobre el negocio"
        staff -> zeroStressSystem "Opera POS"

        zeroStressSystem -> client "Envía comprobantes por email"
        zeroStressSystem -> admin "Envía reportes por email"
        zeroStressSystem -> llm "Analiza información con"
        zeroStressSystem -> whatsapp "Envía respuestas/reportes"
        whatsapp -> zeroStressSystem "Reenvía consultas a través de WhatsApp Business API"

    }

    views {
        systemContext zeroStressSystem {
            include *
            autolayout
        }

        container zeroStressSystem {
            include *
            autolayout lr 
        }

        styles {
            element "Element"{
                shape roundedbox
                background #2f75dd
            }

            element "external"{
                background #8d9197
            }

            element "Person" {
                shape Person
            }
        }
    }
    
    
}