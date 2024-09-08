const express = require("express");
const Service = require("./service");
const router = express.Router();

router.use(express.json());
router.use(express.urlencoded({ extended: true }));

router.get("/", async (req, res) => {
    console.log(req.user);
    const data = await Service.testData();
    return res.status(200).json(data);
});

router.get('/profiles', async (req, res) => {
    try {
        const profiles = await Service.getProfiles();
        res.json(profiles);
    } catch (error) {
        res.status(500).json({ error: 'Failed to retrieve profiles' });
    }
});

router.get('/profiles/:id', async (req, res) => {
    const { id } = req.params;

    try {
        const profile = await Service.getProfile(id);

        if (profile) {
            res.json(profile);
        } else {
            res.status(404).json({ error: 'Profile not found' });
        }
    } catch (error) {
        res.status(500).json({ error: 'Failed to retrieve profile' });
    }
});
router.post('/profiles', async (req, res) => {
    try {
        const { id, email, password, gender, pincode, addr, city, state, country, bank_account_number, account_holder_name, ifsc_code } = req.body;
        if (!email || !password) {
            return res
                .status(400)
                .json({ message: "Email and Password are required.", status: false });
        }
        const profile = await Service.upsertProfile(id, email, password, gender, pincode, addr, city, state, country, bank_account_number, account_holder_name, ifsc_code);
        res.status(201).json(profile);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});
router.delete('/profiles/:id', async (req, res) => {
    const { id } = req.params;
    
    try {
        const profile = await Service.deleteProfile(id);
    
      
      res.json({ message: 'Profile deleted' });
    } catch (error) {
      res.status(500).json({ error: 'Failed to delete profile' });
    }
  });

module.exports = router;
