const fs = require('fs');
const axios = require('axios');

(async () => {
  try {
    const workflowData = JSON.parse(fs.readFileSync('workflow.json', 'utf8'));

    const response = await axios.post('http://localhost:5678/rest/workflows', workflowData, {
      headers: {
        'Content-Type': 'application/json'
      }
    });

    console.log('✅ Workflow loaded:', response.data);
  } catch (error) {
    console.error('❌ Error loading workflow:', error.response?.data || error.message);
  }
})();