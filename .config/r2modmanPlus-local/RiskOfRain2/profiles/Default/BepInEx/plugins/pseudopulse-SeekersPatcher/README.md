# SeekersPatcher

Patches ROR2 to add redirects for things renamed / replaced / removed in both SOTS, it's subsequent patches, and AC that would prevent some mods loading.

# Changelog
## 1.4.1
- restored pickupIndex to ShopTerminalBehaviour and GenericPickupController, once again thanks to .score for this PR

## 1.4.0
- following changes are all courtesy of .score
-- restored BulletAttack _EffectData and _UsePools
-- restored Inventory itemStacks array
-- restored PickupPickerController/Option pickupIndex

## 1.3.8
- fixed cyclic dependency and removed error log that wasnt actually an error

## 1.3.7
- restored CharacterBody.damageFromRecalculateStats (why the fuck did this ever exist gbx did you mix your bolivian with your columbian)

## 1.3.6
- hate. let me tell you how much ive come to hate.
- fixed genuinely this time

## 1.3.5
- fixed for real

## 1.3.4
- fixed a weird ass issue with invisibility

## 1.3.3
- updated for SOTS P3

## 1.3.2
- no longer accidentally bundles goxofbears what the fuck ??? how did

## 1.3.1
- now restores the lantern buff
- actually restores lanter item properly

## 1.3.0
- now restores the 3 items renamed in SOTS P2
## 1.2.0
- now restores HealthComponent.Suicide(GameObject, GameObject, DamageType)