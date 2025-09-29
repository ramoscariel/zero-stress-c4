workspace {

    model {

        # Actors
        admin = person "Admin Zero Stress"
        client = person "Cliente Zero Stress"

        # External Systems
        whatsapp = softwareSystem "WhatsApp" "Plataforma de mensajería (WhatsApp Business API)" "external"
        llm = softwareSystem "LLM" "Sistema de IA" "external"
        
        zeroStressSystem = softwareSystem "Zero Stress Pool Management System" {

        }

        # Relationships
        admin -> zeroStressSystem "gestiona POS y consulta métricas de Piscina Zero Stress"
        admin -> whatsapp "consulta métricas de Piscina Zero Stress"

        zeroStressSystem -> client "Envía comprobantes por email"
        zeroStressSystem -> admin "Envía reportes por email"
        zeroStressSystem -> llm "Analiza información con"
        whatsapp -> zeroStressSystem "Obtiene análisis"
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