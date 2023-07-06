export default {
    "nodes": [
        { "id": "website", "label": "Site", "title": "Site web", "icon": 0xf0ac, "size": 200, "group": 1, "tooltip": "test" },
        { "id": "members", "label": "Membres", "title": "Membres de l'équipe soignante", "icon": 0xf7f2, "size": 100, "group": 2, "tooltip": "test" },
        { "id": "regional_health_agency", "label": "ARS", "icon": 0xf508, "size": 100, "group": 2, "tooltip": "test" },
        { "id": "health_insurance_fund", "label": "CPAM", "icon": 0xf153, "size": 100, "group": 2, "tooltip": "test" },
        { "id": "people", "label": "Usagers", "icon": 0xf0c0, "size": 100, "group": 2, "tooltip": "test" },
        { "id": "health_professional", "label": "PDS", "title": "Professionnels de santé", "icon": 0xf0f0, "size": 100, "group": 2, "tooltip": "test" },
    ],
    "links": [
        { "source": "website", "target": "members", "value": 1 },
        { "source": "website", "target": "regional_health_agency", "value": 1 },
        { "source": "website", "target": "health_insurance_fund", "value": 1 },
        { "source": "website", "target": "people", "value": 1 },
        { "source": "website", "target": "health_professional", "value": 1 }
    ]
}
